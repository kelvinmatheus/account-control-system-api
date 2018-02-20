FactoryBot.define do
  factory :transaction do
    type { 'transfer' }
    origin_account_id { nil }
    destination_account_id { nil }
  end
end
