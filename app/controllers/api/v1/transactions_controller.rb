module API
  module V1
    class TransactionsController < ApplicationController
      before_action :get_account
      before_action :set_transaction, only: [:show]

      # GET /transactions
      def index
        @transactions = @account.transactions

        render json: @transactions
      end

      # GET /transactions/1
      def show
        render json: @transaction
      end

      # POST /transactions
      def create
        # @transaction = Transaction.new(transaction_params)

        @transaction =
          case params[:transaction][:type]
            when 'charge' then ChargeTransaction.new(charge_transaction_params)
            when 'transfer' then TransferTransaction.new(transfer_transaction_params)
            else
              OpenStruct.new(errors: { type: [message: 'must be valid '] }.to_json, perform?: false)
          end

        if @transaction.perform
          head 204, location: api_v1_account_transaction_url(@account, @transaction)
        else
          render json: @transaction.errors, status: 422
        end
      end

      private

      def get_account
        @account = Account.find(params[:account_id])

        rescue
          head 404
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_transaction
        @transaction = @account.find_transaction(params[:id])

        rescue
          head 404
      end

      # Only allow a trusted parameter "white list" through.
      def charge_transaction_params
        params.require(:transaction).permit(:type, :value).merge(origin_account_id: @account.id)
      end

      # Only allow a trusted parameter "white list" through.
      def transfer_transaction_params
        params.require(:transaction).permit(:type, :value, :destination_account_id).merge(origin_account_id: @account.id)
      end
    end

  end
end