require 'spec_helper'

describe HomeController do
  describe "GET index" do
    it "has no user" do
      get :index
      assigns(:current_user).should eq(nil)
      assigns(:welcome_message).should eq("Welcome to Crowd Assistant. Please Log in to get started")
      assigns(:banner_url).should eq("/assets/crowd_graph.png")
    end
    it "has a user" do
      @user = User.create(:name=>"John")
      controller.stub!(:current_user).and_return(@user)
      get :index
      assigns(:current_user).should eq(@user)
      assigns(:welcome_message).should eq("Welcome, #{@user.name}.")
      assigns(:banner_url).should eq("/assets/crowd_graph.png")
    end        
  end
end
