class SessionsController < ApplicationController
  
  def create
    session[:user_id] = nil
    auth = request.env["omniauth.auth"]
    p auth
    p "---------------------------------------------"
    p auth["provider"]
    p auth["uid"]
    p auth["info"]
    
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
