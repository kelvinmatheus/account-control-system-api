class Transaction < ApplicationRecord
  self.inheritance_column = :_type_disabled

  enum type: %i[charge transfer]

  belongs_to :origin_account, class_name: 'Account', foreign_key: 'origin_account_id'
  belongs_to :destination_account, class_name: 'Account', foreign_key: 'destination_account_id', optional: true

  validates :transactional_code, presence: true,
                                 uniqueness: true,
                                 length: { is: 32 }

  validates :value, presence: true,
                    numericality: { greater_than: 0 }

  validates :origin_account_id, presence: true,
                                numericality: { only_integer: true }

  validates :origin_account_value_before_transaction, presence: true,
                                                      numericality: true

  validates :destination_account_id, numericality: { only_integer: true },
                                     allow_nil: { if: Proc.new { |t| t.type == 'charge' } }

  validates :destination_account_value_before_transaction,
            numericality: true,
            allow_nil: { if: Proc.new { |t| t.type == 'charge' } }

  def accounts
    Account.where(id: [origin_account.id, destination_account.id])
  end

  def perform; end

  private

  def registered?
    if Transaction.find_by(transactional_code: transactional_code)
      errors.add(:transactional_code, message: 'is already registered')
      return true
    end

    false
  end

  def set_default_values; end

  def generate_transactional_code(params = {})
    TransactionHelper::Generator.alphanumeric_code(self, params)
  end
end
