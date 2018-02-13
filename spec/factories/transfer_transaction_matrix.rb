FactoryBot.define do
  # destination_account_matrix = create(:valid_legal_person_account)
  # origin_account_subsidiary = create(:valid_legal_person_account, balance: 1000, ancestry: destination_account_matrix.id)
  #
  # transfer = build(
  #   :transaction, origin_account_id: origin_account_subsidiary.id, destination_account_id: destination_account_matrix.id
  # )
  #
  # transactional_code = TransactionHelper::Generator.alphanumeric_code(transfer)

  factory :transfer_transaction_matrix, class: 'Transaction' do
    type { 'transfer' }
    value { 0 }
    destination_account_id { nil }
  end
end