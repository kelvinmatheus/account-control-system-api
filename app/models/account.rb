class Account < ApplicationRecord
  enum status:  %i[canceled activated blocked]

  after_initialize :set_default_values, if: :new_record?

  has_ancestry
  belongs_to :person, polymorphic: true
  has_many :transactions, foreign_key: 'origin_account_id'


  validates :name, presence: true,
                   uniqueness: true,
                   format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ },
                   length: { in: 2..70 }

  validates :balance, presence: true,
                      numericality: true

  validates :status, presence: true

  validates :person_type, presence: true
  validates :person_id, presence: true

  def all_transactions
    Transaction.where('origin_account_id = ? || destination_account_id = ?', id, id)
  end

  def find_transaction(account_id)
    Transaction.where('(origin_account_id = ? || destination_account_id = ?) && id = ?', id, id, account_id).first!
  end

  def activated?
    status == 'activated'
  end

  def canceled?
    status == 'canceled'
  end

  def blocked?
    status == 'blocked'
  end

  def deposit(value)
    return false unless value_can_be_deposit?(value)

    self.balance += value
    save
    self
  end

  def withdraw(value)
    return false unless value_can_be_withdraw?(value)

    self.balance -= value
    save
    self
  end

  def unblock
    return false unless can_be_unblocked?

    update_attribute(:status, :activated)
    reload
    self
  end

  private

  def set_default_values
    self.status = :blocked
    self.balance = 0
  end

  def value_can_be_deposit?(value)
    unless value > 0
      errors.add(:value, message: 'should be greater than 0.')
      return false
    end

    true
  end

  def value_can_be_withdraw?(value)
    unless value <= balance
      errors.add(:balance, message: 'is less than 0 after withdraw.')
      return false
    end

    true
  end

  def can_be_unblocked?
    unless status == 'blocked'
      errors.add(:status, message: 'only blocked accounts can be unblocked.')
      return false
    end

    true
  end
end
