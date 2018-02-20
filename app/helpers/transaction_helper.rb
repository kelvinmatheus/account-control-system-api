module TransactionHelper
  module Generator
    def self.alphanumeric_code(transaction, params = {})
      return false unless alphanumeric_code_params_valid?(transaction, params)

      date =
        if params[:date]
          stringfy_date(params[:date]) || ''
        else
          stringfy_date(Time.now) || ''
        end

      origem_account_id = transaction.origin_account_id.to_s
      destination_account_id = transaction.destination_account_id.to_s
      type = transaction.type.to_s

      data_to_encrypt = date + origem_account_id + type + destination_account_id

      Digest::MD5.hexdigest(data_to_encrypt)
    end

    private

    def self.alphanumeric_code_params_valid?(transaction, params)
      return false if params[:data] && !params[:data].is_a?(Time)
      return false if transaction.origin_account_id.blank?

      true
    end

    def self.stringfy_date(date)
      # YYYYMMDDHHMMSSLLL

      return false unless date.is_a?(Time)

      date.strftime('%Y%m%d%H%M%S%L')
    end

  end
end