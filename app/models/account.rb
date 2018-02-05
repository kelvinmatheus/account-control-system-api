class Account < ApplicationRecord
  enum status:  %i[canceled actived blocked]

  has_ancestry

  belongs_to :person, polymorphic: true

  validates :name, presence: true,
                   uniqueness: true,
                   format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ },
                   length: { in: 2..70 }

  validates :balance, presence: true,
                      numericality: true

  validates :status, presence: true

  validates :person_type, presence: true
  validates :person_id, presence: true
end
