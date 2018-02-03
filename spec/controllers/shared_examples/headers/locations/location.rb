RSpec.shared_examples 'location' do
  it { expect(response.location).to have_location(expected_location) }
end
