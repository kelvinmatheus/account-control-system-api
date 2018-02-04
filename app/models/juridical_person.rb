class JuridicalPerson < ApplicationRecord
  has_many :accounts, as: :person

  validates :cnpj, presence: true,
                   uniqueness: true,
                   numericality: { only_integer: true },
                   length: { is: 14 }

  validates :company_name, presence: true,
                           uniqueness: true,
                           format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ },
                           length: { in: 2..70 }

  validates :fantasy_name, presence: true,
                           uniqueness: true,
                           format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ },
                           length: { in: 2..70 }
end
