RSpec.shared_examples '422 - :unprocessable_entity' do
  it { expect(response).to have_http_status(422) }
end
