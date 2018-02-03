RSpec.shared_examples 'GET #index' do |klass|
  before { get :index, params: params }

  it "returns an array of valid #{klass.to_s.underscore.pluralize}" do
    objects_response = symbolize_json(response.body)

    specific_field_array = objects_response.collect { |lp| lp[expected_object_attribute.to_sym] }

    assert_includes specific_field_array, expected_object.try(expected_object_attribute.to_sym)
  end

  it 'cannot accept an empty body' do
    refute_empty response.body
  end

  context 'returns expected status code' do
    it_behaves_like '200 - :ok'
  end

  context 'returns expected content_type' do
    it_behaves_like 'content_type JSON'
  end
end

# klass                      -> class to be tested
# params                     -> a hash to be sent with the request
# expected_object            -> expected object to be used as a comparison
# expected_object_attribute  -> object's attribute to be checked to ensure that the object saved was returned as expected.

# Note: object must me saved in the file who uses this shared example.
