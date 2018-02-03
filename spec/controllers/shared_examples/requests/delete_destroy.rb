RSpec.shared_examples 'DELETE #destroy' do |klass|
  context 'with valid id' do
    it 'destroys the requested legal_person' do
      expect {
        delete :destroy, params: { id: object_to_destroy.to_param }
      }.to change(klass, :count).by(-1)
    end

    context 'returns expected status code' do
      before { delete :destroy, params: { id: object_to_destroy.to_param } }

      it_behaves_like '204 - :created'
    end
  end

  context 'with invalid id' do
    before { delete :destroy, params: { id: 0 } }

    context 'returns expected status code' do
      it_behaves_like '404 - :not_found'
    end
  end
end
