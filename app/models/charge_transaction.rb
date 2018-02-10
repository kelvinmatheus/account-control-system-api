class ChargeTransaction < Transaction
  def perform
    return false if registered?
    set_charge_transaction
    return false unless valid_transaction?

    begin
      ActiveRecord::Base.transaction do
        self.origin_account.deposit(self.value)
        self.save
      end

      raise unless self.errors.messages.blank?

      self
    rescue
      self.errors.messages.merge(self.origin_account.errors.messages)
      false
    end

  end

  private

  def set_charge_transaction
    self.origin_account_value_before_transaction = origin_account.balance if origin_account_id
    self.transactional_code = generate_transactional_code
  end

  def valid_transaction?
    errors.add(:value, :not_zero_or_negative, message: 'cannot be zero or negative') if value <= 0
    errors.add(:destination_account_id, :not_blank, message: 'cannot be provided') if destination_account_id
    errors.add(:destination_account_value_before_transaction, :not_blank, message: 'cannot be provided') if destination_account_value_before_transaction
    errors.add(:origin_account, :blank) unless origin_account
    errors.add(:origin_account, :not_activated, message: 'should be activated') if origin_account && !origin_account.activated?

    return true if errors.messages.blank?
    false
  end
end