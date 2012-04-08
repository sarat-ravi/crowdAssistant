require 'spec_helper'


describe UsersController do

  describe "GET index" do
    it "assigns user" do
      user = User.create!
      controller.stub!(:current_user).and_return(user)
      get :index
      assigns(:user).should eq(user)
      response.should render_template("index")
    end
  end
end
