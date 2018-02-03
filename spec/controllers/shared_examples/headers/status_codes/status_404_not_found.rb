RSpec.shared_examples '404 - :not_found' do
  it { expect(response).to have_http_status(404) }
end
