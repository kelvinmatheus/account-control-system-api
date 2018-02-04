require 'rails_helper'

RSpec.describe "JuridicalPeople", type: :request do
  describe "GET /juridical_people" do
    it "works! (now write some real specs)" do
      get juridical_people_path
      expect(response).to have_http_status(200)
    end
  end
end
