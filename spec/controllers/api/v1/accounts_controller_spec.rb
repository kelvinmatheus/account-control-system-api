require 'rails_helper'

RSpec.describe API::V1::AccountsController, type: :controller do

  before { @request.host = 'api.example.com' }
  before do
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    request.headers.merge! headers
  end

  let!(:legal_person_account) { create(:valid_legal_person_account) }
  let(:valid_attributes) { attributes_for(:valid_legal_person_account) }
  let(:invalid_attributes) { attributes_for(:invalid_legal_person_account) }

  describe 'GET #index' do
    it_behaves_like 'GET #index', Account do
      let(:params) { {} }
      let(:expected_object) { legal_person_account }
      let(:expected_object_attribute) { :name }
    end
  end

  describe 'GET #show' do
    it_behaves_like 'GET #show', Account do
      let(:params) { { id: legal_person_account.to_param } }
      let(:expected_object) { legal_person_account }
      let(:expected_object_attribute) { :name }
    end
  end

  describe 'POST #create' do
    it_behaves_like 'POST #create', Account do
      let(:valid_params) { { account: valid_attributes } }
      let(:invalid_params) { { account: invalid_attributes } }
      let(:expected_object_location) { api_v1_account_url(Account.last) }
    end
  end

  describe 'PATCH #update' do
    it_behaves_like 'PATCH #update', Account do
      let(:object_to_update) { legal_person_account }
      let(:attribute_to_check) { :name }

      let(:valid_params) { { account: valid_attributes } }
      let(:invalid_params) { { account: invalid_attributes } }
    end
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'DELETE #destroy', Account do
      let(:object_to_destroy) { legal_person_account }
    end
  end
end
