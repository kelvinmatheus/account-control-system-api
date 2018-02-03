RSpec.shared_examples 'POST #create' do |klass|
  context 'with valid params' do
    context 'and correct response header' do
      before { post :create, body: valid_params.to_json }

      context 'returns expected status code' do
        it_behaves_like '204 - :created'
      end

      context 'returns expected location' do
        it_behaves_like 'location' do
          let(:expected_location) { expected_object_location }
        end
      end
    end

    it 'creates a new LegalPerson' do
      expect {
        post :create, body: valid_params.to_json
      }.to change(klass, :count).by(1)
    end
  end

  context 'with invalid params' do
    context 'and correct response header' do
      before { post :create, body: invalid_params.to_json }

      context 'returns expected status code' do
        it_behaves_like '422 - :unprocessable_entity'
      end

      context 'returns expected content_type' do
        it_behaves_like 'content_type JSON'
      end
    end

    it 'does not create a new legal_person' do
      expect {
        post :create, body: invalid_params.to_json
      }.not_to change(klass, :count)
    end
  end
end

# klass                       -> class to be tested
# valid_params                -> a hash to be sent with the request. It must have the 'hash' class with the valid attributes to be saved.
# invalid_params              -> a hash to be sent with the request. It must have the 'hash' class with the invalid attributes to be saved.
# expected_object_location    -> the URL generated with the object created. For example, api_v1_legal_person_url(LegalPerson.last)
# Note: object must me saved in the file who uses this shared example.
