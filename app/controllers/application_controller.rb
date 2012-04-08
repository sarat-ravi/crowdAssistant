class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def call_rake(task, options = {})
  	options[:rails_env] ||= Rails.env
  	args = options.map{ |n, v| "#{n.to_s.upcase}='#{v}'" }
  	p options
  	system "rake #{task} #{args.join(' ')}"
  end  
end
