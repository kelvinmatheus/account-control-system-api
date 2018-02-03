RSpec.shared_examples 'PATCH #update' do |klass|
  context 'with valid params' do
    context 'with valid id' do
      before { patch :update, params: { id: object_to_update.to_param }, body: valid_params.to_json }

      context 'returns expected status code' do
        it_behaves_like '200 - :ok'
      end

      context 'returns expected content_type' do
        it_behaves_like 'content_type JSON'
      end

      it 'should update legal_person' do
        object_to_update.reload
        expect(object_to_update.send(attribute_to_check)).to eq(valid_params[symbolize_klass(klass)][attribute_to_check])
      end
    end

    context 'with invalid id' do
      before { patch :update, params: { id: 0 }, body: valid_params.to_json }

      it_behaves_like '404 - :not_found'
    end

  end

  context 'with invalid params' do
    context 'with valid id' do
      before { patch :update, params: { id: object_to_update.to_param }, body: invalid_params.to_json }

      context 'returns expected status code' do
        it_behaves_like '422 - :unprocessable_entity'
      end

      context 'returns expected content_type' do
        it_behaves_like 'content_type JSON'
      end

      it 'should not update legal_person' do
        object_to_update.reload
        expect(object_to_update.send(attribute_to_check)).not_to eq(invalid_params[symbolize_klass(klass)][attribute_to_check])
      end
    end

    context 'with invalid id' do
      before { patch :update, params: { id: 0 }, body: invalid_params.to_json }

      it_behaves_like '404 - :not_found'
    end

  end
end

# klass                      -> class to be tested
# object_to_update           -> the object that will be updated
# attribute_to_check         -> an attribute from the same object to check if it was updated or not after the request
# valid_params               -> a hash to be sent with the request. It must have the 'hash' class with the valid attributes to be saved. For instance: { legal_person: valid_attributes }
#
# invalid_params             -> a hash to be sent with the request. It must have the 'hash' class with the invalid attributes to be saved. for instance, { legal_person: invalid_attributes }
# Note: object must me saved in the file who uses this shared example.
