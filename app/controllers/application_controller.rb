class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user

  def current_user

    if Rails.env.test?
      @current_user = User.find_by_name("John")
      #@current_user = User.create! if @current_user.nil?
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
end
