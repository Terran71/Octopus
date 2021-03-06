require "rails_helper"

RSpec.describe ProjectRestrictionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/project_restrictions").to route_to("project_restrictions#index")
    end

    it "routes to #new" do
      expect(:get => "/project_restrictions/new").to route_to("project_restrictions#new")
    end

    it "routes to #show" do
      expect(:get => "/project_restrictions/1").to route_to("project_restrictions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/project_restrictions/1/edit").to route_to("project_restrictions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/project_restrictions").to route_to("project_restrictions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/project_restrictions/1").to route_to("project_restrictions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/project_restrictions/1").to route_to("project_restrictions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/project_restrictions/1").to route_to("project_restrictions#destroy", :id => "1")
    end

  end
end
