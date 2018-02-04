require 'rails_helper'

RSpec.describe API::V1::JuridicalPeopleController, type: :controller do

  before { @request.host = 'api.example.com' }
  before do
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    request.headers.merge! headers
  end

  let!(:juridical_person) { create(:juridical_person) }
  let(:valid_attributes) { attributes_for(:valid_juridical_person) }
  let(:invalid_attributes) { attributes_for(:invalid_juridical_person) }

  describe 'GET #index' do
    it_behaves_like 'GET #index', JuridicalPerson do
      let(:params) { {} }
      let(:expected_object) { juridical_person }
      let(:expected_object_attribute) { :cnpj }
    end
  end

  describe 'GET #show' do
    it_behaves_like 'GET #show', JuridicalPerson do
      let(:params) { { id: juridical_person.to_param } }
      let(:expected_object) { juridical_person }
      let(:expected_object_attribute) { :cnpj }
    end
  end

  describe 'POST #create' do
    it_behaves_like 'POST #create', JuridicalPerson do
      let(:valid_params) { { juridical_person: valid_attributes } }
      let(:invalid_params) { { juridical_person: invalid_attributes } }
      let(:expected_object_location) { api_v1_juridical_person_url(JuridicalPerson.last) }
    end
  end

  describe 'PATCH #update' do
    it_behaves_like 'PATCH #update', JuridicalPerson do
      let(:object_to_update) { juridical_person }
      let(:attribute_to_check) { :cnpj }

      let(:valid_params) { { juridical_person: valid_attributes } }
      let(:invalid_params) { { juridical_person: invalid_attributes } }
    end
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'DELETE #destroy', JuridicalPerson do
      let(:object_to_destroy) { juridical_person }
    end
  end
end
