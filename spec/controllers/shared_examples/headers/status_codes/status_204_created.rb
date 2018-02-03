RSpec.shared_examples '204 - :created' do
  it { expect(response).to have_http_status(204) }
end
