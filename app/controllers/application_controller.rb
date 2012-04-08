class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user

  def current_user
    @current_user ||= Rails.env.test? ? User.find_by_name("John") : (User.find(session[:user_id]) if session[:user_id])
  end
end