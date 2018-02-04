require "rails_helper"

RSpec.describe JuridicalPeopleController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/juridical_people").to route_to("juridical_people#index")
    end


    it "routes to #show" do
      expect(:get => "/juridical_people/1").to route_to("juridical_people#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/juridical_people").to route_to("juridical_people#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/juridical_people/1").to route_to("juridical_people#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/juridical_people/1").to route_to("juridical_people#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/juridical_people/1").to route_to("juridical_people#destroy", :id => "1")
    end

  end
end
