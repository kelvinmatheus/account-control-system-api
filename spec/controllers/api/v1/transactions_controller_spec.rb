require 'rails_helper'

RSpec.describe API::V1::TransactionsController, type: :controller do

  before { @request.host = 'api.example.com' }
  before do
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    request.headers.merge! headers
  end

  context 'Charge Transaction' do
    let!(:charge_transaction) { create(:charge_transaction, :valid_attributes) }
    let!(:valid_attributes) { attributes_for(:charge_transaction, :valid_attributes) }
    let!(:invalid_attributes) { attributes_for(:charge_transaction, :invalid_attributes) }

    let!(:account) { create(:valid_legal_person_account, :activated) }

    context 'GET #index' do
      it_behaves_like 'GET #index', ChargeTransaction do
        let(:params) { { account_id: charge_transaction.origin_account_id} }
        let(:expected_object) { charge_transaction }
        let(:expected_object_attribute) { :transactional_code }
      end
    end

    context 'GET #show' do
      it_behaves_like 'GET #show', ChargeTransaction do
        let(:params) { { account_id: charge_transaction.origin_account_id, id: charge_transaction.id } }
        let(:invalid_params) { { account_id: charge_transaction.origin_account_id, id: 0 } }
        let(:expected_object) { charge_transaction }
        let(:expected_object_attribute) { :transactional_code }
      end
    end

    context 'POST #create' do
      it_behaves_like 'POST #create', ChargeTransaction do
        let(:valid_params) { { account_id: account.id, transaction: valid_attributes } }
        let(:invalid_params) { { account_id: account.id, transaction: invalid_attributes } }

        let(:expected_object_location) { api_v1_account_transaction_url(account, Transaction.last) }
      end
    end
  end

  context 'Transfer Transaction' do
    let!(:account) { create(:valid_legal_person_account, :activated, balance: 1000) }
    let!(:matrix_account) { create(:valid_legal_person_account, :activated, balance: 1000) }
    let!(:subsidiary_account) { create(:valid_legal_person_account, :activated, balance: 1000, ancestry: matrix_account.id) }
    let!(:valid_attributes) { attributes_for(:transfer_transaction_matrix, destination_account_id: subsidiary_account.id, value: 500) }
    let!(:valid_attributes_matrix_destination) { attributes_for(:transfer_transaction_matrix, destination_account_id: matrix_account.id, value: 500) }

    let!(:invalid_attributes) { attributes_for(:transfer_transaction_matrix, destination_account_id: subsidiary_account.id, value: 500) }

    describe 'POST #create' do
      context 'with valid attributes' do
        context 'and same hierarchy' do
          it 'should transfer value to account' do
            expect {
              post :create, params: { account_id: matrix_account.id, transaction: valid_attributes }
            }.to change(Transaction, :count).by(1)

            expect(matrix_account.reload.balance.to_f).to eq(500)
            expect(subsidiary_account.reload.balance.to_f).to eq(1500)
          end

          it 'should not transfer value to matrix account' do
            expect {
              post :create, params: { account_id: subsidiary_account.id, transaction: valid_attributes_matrix_destination }
            }.not_to change(Transaction, :count)

            expect(matrix_account.reload.balance.to_f).to eq(1000)
            expect(subsidiary_account.reload.balance.to_f).to eq(1000)
          end
        end

        context 'and different hierarchy' do
          it 'should not transfer value to account' do
            expect {
              post :create, params: { account_id: account.id, transaction: valid_attributes }
            }.not_to change(Transaction, :count)

            expect(matrix_account.reload.balance.to_f).to eq(1000)
            expect(subsidiary_account.reload.balance.to_f).to eq(1000)
          end
        end
      end
    end

  end
end
