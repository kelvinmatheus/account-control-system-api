FactoryBot.define do
  factory :charge_transaction, parent: :transaction do
    type { :charge }

    trait :valid_attributes do
      value { 500 }
      origin_account_id { FactoryBot.create(:valid_legal_person_account).id }

      transactional_code nil
      origin_account_value_before_transaction nil
      destination_account_id nil
      destination_account_value_before_transaction nil

      after(:build) do |charge_transaction|
        transactional_code = TransactionHelper::Generator.alphanumeric_code(charge_transaction)

        charge_transaction.transactional_code = transactional_code
        charge_transaction.origin_account_value_before_transaction = charge_transaction.origin_account.balance
      end
    end

    trait :invalid_attributes do
      value 0
      origin_account_id nil
      transactional_code nil
      origin_account_value_before_transaction nil
      destination_account_id nil
      destination_account_value_before_transaction nil
    end

  end
end