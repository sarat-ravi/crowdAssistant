require 'spec_helper'

describe ApplicationController do

  before(:each) do
    @user = User.create!
  end
  describe "current user" do
    it "returns the current user" do
      user = User.create!
      session[:user] = user
      #current_user
      assigns(:current_user).should eq(user)
    end
    it "has no current user" do
      session[:user] = nil
      #current_user
      assigns(:current_user).should eq(nil)
    end
  end
end
