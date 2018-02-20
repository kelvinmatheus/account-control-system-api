class Account < ApplicationRecord
  attr_accessor :ancestry_id

  enum status:  %i[canceled activated blocked]

  after_initialize :set_default_values, if: :new_record?
  before_update :can_be_updated?
  validate :ancestry_valid?

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
    return false unless value_can_be_deposited?(value)

    self.balance += value
    save
    self
  end

  def withdraw(value)
    return false unless value_can_be_withdrawn?(value)

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
    self.status = 'blocked'
    self.balance = 0
  end

  def value_can_be_deposited?(value)
    unless value > 0
      errors.add(:value, message: 'should be greater than 0.')
      return false
    end

    true
  end

  def value_can_be_withdrawn?(value)
    unless value <= balance
      errors.add(:balance, message: 'is less than 0 after withdraw.')
      return false
    end

    true
  end

  def can_be_unblocked?
    unless blocked?
      errors.add(:status, message: 'only blocked accounts can be unblocked.')
      return false
    end

    true
  end

  def can_be_updated?
    unless activated?
      errors.add(:account, message: 'can only be updated if it is activated.')
      return false
    end

    true
  end

  def ancestry_valid?
    return true if ancestry_id.blank?

    ancestry_account = Account.find_by(id: valid_ancestry_id(ancestry_id))

    unless ancestry_account
      errors.add(:ancestry_account, message: 'should exist.')
      return false
    end

    if ancestry_is_itself?(ancestry_account)
      errors.add(:ancestry_account, message: 'should not be itself.')
      return false
    end

    if ancestry_is_account_descendant?(ancestry_account)
      errors.add(:ancestry_account, message: 'should not be account descendant.')
      return false
    end

    if ancestry_account && !ancestry_is_same_hierarchy?(ancestry_account) && ancestry
      errors.add(:ancestry_account, message: 'should be in the same hierarchy.')
      return false
    end

    self.parent = ancestry_account
    true
  end

  def valid_ancestry_id(ancestry_id)
    ancestry_id.to_s.split('/').last
  end

  def ancestry_is_itself?(ancestry_account)
    ancestry_account.id == id
  end

  def ancestry_is_same_hierarchy?(ancestry_account)
    ancestry_account.root_id == root_id
  end

  def ancestry_is_account_descendant?(ancestry_account)
    descendant_ids.include?(ancestry_account.id)
  end
end
