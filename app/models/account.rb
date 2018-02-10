class Account < ApplicationRecord
  enum status:  %i[canceled activated blocked]

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
    return self unless value_valid?(value)

    self.balance += value
    self
  end

  private

  def value_valid?(value)
    unless value > 0
      errors.add(:value, message: 'should be greater than 0.')
      return false
    end

    true
  end
end
