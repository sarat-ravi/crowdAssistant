require "spec_helper"

describe AssistantsController do
  describe "routing" do

    it "routes to #index" do
      get("/assistants").should route_to("assistants#index")
    end

    it "routes to #new" do
      get("/assistants/new").should route_to("assistants#new")
    end

    it "routes to #show" do
      get("/assistants/1").should route_to("assistants#show", :id => "1")
    end

    it "routes to #edit" do
      get("/assistants/1/edit").should route_to("assistants#edit", :id => "1")
    end

    it "routes to #create" do
      post("/assistants").should route_to("assistants#create")
    end

    it "routes to #update" do
      put("/assistants/1").should route_to("assistants#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/assistants/1").should route_to("assistants#destroy", :id => "1")
    end

  end
end
