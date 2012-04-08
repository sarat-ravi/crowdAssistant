require 'spec_helper'

describe ApplicationController do

  before(:each) do
    @user = User.create!
  end
  describe "current user" do
    it "returns the user" do
      user = User.create!()
      assigns(:current_user).should eq(nil)
    end
  end
end
