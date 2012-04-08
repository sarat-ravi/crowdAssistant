require 'spec_helper'

describe ProfilesController do

  def valid_attributes
    {}
  end

  def valid_session
    {}
  end
  before(:each) do
    @user = User.create!
    controller.stub!(:current_user).and_return(@user)
  end
  describe "GET index" do
    it "assigns profile as @profile" do
      profile = Profile.create(:user_id => @user.id)
      get :index, {}, valid_session
      assigns(:profile).should eq(profile)
    end
  end

  describe "GET edit" do
    it "assigns the requested profile as @profile" do
      profile = Profile.create(:user_id => @user.id)
      get :edit, {:id => profile.to_param}, valid_session
      assigns(:profile).should eq(profile)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested profile" do
        profile = Profile.create(:user_id => @user.id)
        Profile.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => profile.to_param, :profile => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested profile as @profile" do
        profile = Profile.create(:user_id => @user.id)
        put :update, {:id => profile.to_param, :profile => valid_attributes}, valid_session
        assigns(:profile).should eq(profile)
      end

      it "redirects to the profile" do
        profile = Profile.create(:user_id => @user.id)
        put :update, {:id => profile.to_param, :profile => valid_attributes}, valid_session
        response.should redirect_to("/profile")
      end
    end

    describe "with invalid params" do
      it "assigns the profile as @profile" do
        profile = Profile.create(:user_id => @user.id)
        Profile.any_instance.stub(:save).and_return(false)
        put :update, {:id => profile.to_param, :profile => {}}, valid_session
        assigns(:profile).should eq(profile)
      end

      it "re-renders the 'edit' template" do
        profile = Profile.create(:user_id => @user.id)
        Profile.any_instance.stub(:save).and_return(false)
        put :update, {:id => profile.to_param, :profile => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

end
