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
    before { get :index, params: { format: JSON } }

    it 'returns status code 200 - :ok' do
      expect(response).to have_http_status(200)
    end

    it 'cannot accept an empty body' do
      refute_empty response.body
    end

    it 'returns an array of valid legal_people' do
      legal_people_response = symbolize_json(response.body)

      names = legal_people_response.collect { |lp| lp[:name] }

      assert_includes names, legal_person.name
    end

    it 'expects Mime type to be JSON' do
      expect(response.content_type).to eq('application/json')
    end
  end

  describe 'GET #show' do
    context 'with valid id' do
      before { get :show, params: { id: legal_person.to_param } }

      it { expect(response).to have_http_status(200) }
      it { expect(response).to have_content_type('application/json') }

      it 'returns a legal person valid' do
        legal_person_response = symbolize_json(response.body)
        expect(legal_person_response[:name]).to eq(legal_person.name)
      end
    end

    context 'with invalid id' do
      before { get :show, params: { id: 0 } }

      it { expect(response).to have_http_status(404) }
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      context 'and correct response header' do
        before { post :create, params: { legal_person: valid_attributes } }

        it { expect(response).to have_http_status(204) }
        it { expect(response.location).to have_location(api_v1_legal_person_url(LegalPerson.last)) }
      end

      it 'creates a new LegalPerson' do
        expect {
          post :create, params: { legal_person: valid_attributes }
        }.to change(LegalPerson, :count).by(1)
      end
    end

    context 'with invalid params' do
      context 'and correct response header' do
        before { post :create, params: { legal_person: invalid_attributes } }

        it { expect(response).to have_http_status(422) }
        it { expect(response.content_type).to eq('application/json') }
      end

      it 'does not create a new legal_person' do
        expect {
          post :create, params: { legal_person: invalid_attributes }
        }.not_to change(LegalPerson, :count)
      end
    end
  end


  describe 'PUT #update' do
    context 'with valid params' do
      context 'and correct response header' do
        before { put :update, params: { id: legal_person.to_param, legal_person: valid_attributes } }

        it { expect(response).to have_http_status(200) }
        it { expect(response).to have_content_type('application/json') }

        it 'should update legal_person' do
          legal_person.reload
          expect(legal_person.cpf).to eq(valid_attributes[:cpf])
        end
      end
    end

    context 'with invalid params' do
      context 'with valid id' do
        before { put :update, params: { id: legal_person.to_param, legal_person: invalid_attributes } }

        it { expect(response).to have_http_status(422) }
        it { expect(response).to have_content_type('application/json') }

        it 'should update legal_person' do
          legal_person.reload
          expect(legal_person.cpf).not_to eq(valid_attributes[:cpf])
        end
      end

      context 'with invalid id' do
        before { put :update, params: { id: 0, legal_person: invalid_attributes } }

        it { expect(response).to have_http_status(404) }
      end

    end
  end

  describe 'DELETE #destroy' do
    context 'with valid id' do
      it 'destroys the requested legal_person' do
        expect {
          delete :destroy, params: { id: legal_person.to_param }
        }.to change(LegalPerson, :count).by(-1)
      end

      it 'should respond with numeric status code 204' do
        delete :destroy, params: { id: legal_person.to_param }
        expect(response).to have_http_status(204)
      end
    end

    context 'with invalid id' do
      before { delete :destroy, params: { id: 0 } }

      it { expect(response).to have_http_status(404) }
    end
  end

end
