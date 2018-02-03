require 'rails_helper'

RSpec.describe API::V1::LegalPeopleController, type: :controller do

  before { @request.host = 'api.example.com' }
  before do
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json'.to_s }
    request.headers.merge! headers
  end

  let!(:legal_person) { create(:legal_person) }
  let(:valid_attributes) { attributes_for(:valid_legal_person) }
  let(:invalid_attributes) { attributes_for(:invalid_legal_person) }

  describe 'GET #index' do
    it_behaves_like 'GET #index', LegalPerson do
      let(:params) { {} }
      let(:expected_object) { legal_person }
      let(:expected_object_attribute) { 'cpf' }
    end
  end

  describe 'GET #show' do
    it_behaves_like 'GET #show', LegalPerson do
      let(:params) { { id: legal_person.to_param } }
      let(:expected_object) { legal_person }
      let(:expected_object_attribute) { 'cpf' }
    end
  end

  describe 'POST #create' do
    it_behaves_like 'POST #create', LegalPerson do
      let(:valid_params) { { legal_person: valid_attributes } }
      let(:invalid_params) { { legal_person: invalid_attributes } }
      let(:expected_object_location) { api_v1_legal_person_url(LegalPerson.last) }
    end
  end

  describe 'PATCH #update' do
    it_behaves_like 'PATCH #update', LegalPerson do
      let(:object_to_update) { legal_person }
      let(:attribute_to_check) { :cpf }

      let(:valid_params) { { legal_person: valid_attributes } }
      let(:invalid_params) { { legal_person: invalid_attributes } }
    end
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'DELETE #destroy', LegalPerson do
      let(:object_to_destroy) { legal_person }
    end
  end

end
