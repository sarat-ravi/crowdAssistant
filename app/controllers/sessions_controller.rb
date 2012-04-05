class SessionsController < ApplicationController
  
  def create
    session[:user_id] = nil
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    p user
    if not user
      user = User.create_with_omniauth(auth)
      UserMailer.welcome_email(user).deliver
    end
    p user
    pic_url = auth["info"]["image"].sub!(/type=square/, 'type=large')
    profile = Profile.find_by_user_id(user.id) || Profile.create(:user_id=>user.id, :pic_url => auth["info"]["image"])
    session[:user_id] = user.id
    redirect_to '/user', :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
