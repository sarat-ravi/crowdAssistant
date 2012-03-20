require "spec_helper"

describe MobworkersController do
  describe "routing" do

    it "routes to #index" do
      get("/mobworkers").should route_to("mobworkers#index")
    end

    it "routes to #new" do
      get("/mobworkers/new").should route_to("mobworkers#new")
    end

    it "routes to #show" do
      get("/mobworkers/1").should route_to("mobworkers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mobworkers/1/edit").should route_to("mobworkers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mobworkers").should route_to("mobworkers#create")
    end

    it "routes to #update" do
      put("/mobworkers/1").should route_to("mobworkers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mobworkers/1").should route_to("mobworkers#destroy", :id => "1")
    end

  end
end
