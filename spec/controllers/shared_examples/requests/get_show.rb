RSpec.shared_examples 'GET #show' do |klass|
  context 'with valid id' do
    before { get :show, params: params }

    it 'returns a legal person valid' do
      objects_response = symbolize_json(response.body)
      expect(objects_response[expected_object_attribute.to_sym]).to eq(expected_object.try(expected_object_attribute.to_sym))
    end

    context 'returns expected status code' do
      it_behaves_like '200 - :ok'
    end

    context 'returns expected content_type' do
      it_behaves_like 'content_type JSON'
    end
  end

  context 'with invalid id' do
    before { get :show, params: { id: 0 } }

    it_behaves_like '404 - :not_found'
  end
end

# klass                       -> class to be tested
# params                      -> a hash to be sent with the request. It must have the 'id' of the object to be searched
# expected_object             -> expected object to be used as a comparison
# expected_object_attribute   -> object's attribute to be checked to ensure that the object saved was returned as expected.

# Note: object must me saved in the file who uses this shared example.
