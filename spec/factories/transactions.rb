FactoryBot.define do
  factory :transaction do
    transactional_code "MyString"
    type 1
    value "9.99"
    origin_account_id 1
    origin_account_value_before_transaction "9.99"
    destination_account_id 1
    destination_account_value_before_transaction "9.99"
  end
end
