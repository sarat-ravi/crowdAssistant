class UserMailer < ActionMailer::Base
  default from: "CrowdAssistant@gmail.com"
  def receive(email)
  	p "---------------------"
  	p email
  	p "---------------------"
  end
  def welcome_email(user)
  	@user = user
  	mail(:to => user.email, :subject => "Welcome to CrowdAssistant")
  end
end