require 'rspec/expectations'

RSpec::Matchers.define :have_location do |expected|
  match do |actual|
    actual == expected
  end

  description do
    "respond with location #{expected}"
  end
end