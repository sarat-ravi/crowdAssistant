require "spec_helper"

describe HomeController do
  describe "routing" do

    it "routes to #index" do
      get("/home").should route_to("home#index")
    end

  end
end
