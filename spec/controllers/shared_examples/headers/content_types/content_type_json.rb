RSpec.shared_examples 'content_type JSON' do
  it { expect(response).to have_content_type('application/json') }
end
