require 'rspec/expectations'

RSpec::Matchers.define :have_content_type do |expected|
  match do |actual|
    actual.content_type == expected
  end

  description do
    "respond with content_type #{expected}"
  end
end