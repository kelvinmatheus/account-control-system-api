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

end
