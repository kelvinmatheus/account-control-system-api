class LegalPerson < ApplicationRecord
  has_many :accounts, as: :person

  validates :cpf, presence: true,
                  uniqueness: true,
                  numericality: { only_integer: true },
                  length: { is: 11 }

  validates :name, presence: true,
                   format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ },
                   length: { in: 2..70 }

  validates :birthdate, presence: true
  validates_date :birthdate, on_or_before: -> { Date.today }
end
