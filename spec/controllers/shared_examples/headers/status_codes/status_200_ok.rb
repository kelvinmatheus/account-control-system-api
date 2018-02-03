RSpec.shared_examples '200 - :ok' do
  it { expect(response).to have_http_status(200) }
end
