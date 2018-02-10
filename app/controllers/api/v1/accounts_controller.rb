module API
  module V1
    class AccountsController < ApplicationController
      before_action :set_account, only: [:show, :update, :destroy, :unblock]

      # GET /accounts
      def index
        @accounts = Account.all

        render json: @accounts, status: 200
      end

      # GET /accounts/1
      def show
        render json: @account, status: 200
      end

      # POST /accounts
      def create
        @account = Account.new(account_params)

        if @account.save
          render json: @account, status: 204, location: api_v1_account_url(@account)
        else
          render json: @account.errors, status: 422
        end
      end

      # PATCH/PUT /accounts/1
      def update
        if @account.update(account_params)
          render json: @account, status: 200
        else
          render json: @account.errors, status: 422
        end
      end

      # DELETE /accounts/1
      def destroy
        @account.destroy

        head 204
      end

      def unblock
        if @account.unblock
          render json: @account, status: 200
        else
          render json: @account.errors, status: 422
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_account
        @account = Account.find(params[:id])

        rescue
          head 404
      end

      # Only allow a trusted parameter "white list" through.
      def account_params
        params.require(:account).permit(:name, :person_type, :person_id, :ancestry)
      end

      def update_account_params
        params.require(:account).permit(:name, :ancestry)
      end

    end

  end
end