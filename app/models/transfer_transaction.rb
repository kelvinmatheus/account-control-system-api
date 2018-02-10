class TransferTransaction < Transaction
  def perform
    return false if registered?
    set_charge_transaction
    return false unless valid_transaction?

    begin
      ActiveRecord::Base.transaction do
        raise unless origin_account.withdraw(value)
        raise unless destination_account.deposit(value)
        save
      end

      raise unless errors.messages.blank?

    rescue
      self.errors.messages.merge!(origin_account.errors.messages)
      self.errors.messages.merge!(destination_account.errors.messages)
      return false
    end

    self
  end

  private

  def set_charge_transaction
    self.origin_account_value_before_transaction = origin_account.balance if origin_account_id
    self.destination_account_value_before_transaction = destination_account.balance if destination_account_id
    self.transactional_code = generate_transactional_code
  end

  def valid_transaction?
    errors.add(:value, :not_zero_or_negative, message: 'cannot be zero or negative') if value <= 0
    errors.add(:origin_account, :blank) unless origin_account
    errors.add(:destination_account, :blank) unless destination_account

    if origin_account_id
      errors.add(:origin_account, :not_active, message: 'should be activated') unless origin_account.activated?
    end

    if destination_account_id
      errors.add(:destination_account, :matrix, message: 'is a matrix account. It cannot receive transfers.') if destination_account.root.id == destination_account.id
      errors.add(:destination_account, :not_active, message: 'should be activated') unless destination_account.activated?
      errors.add(:destination_account_id, :incosistent, message: 'cannot transfer to the same account.') if destination_account_id == origin_account.id
    end

    if origin_account.id && destination_account_id
      errors.add(:accounts, :not_hierarchical, message: 'should have the same hierarchy') if origin_account.root.id != destination_account.root.id
    end

    return true if errors.messages.blank?
    false
  end
end