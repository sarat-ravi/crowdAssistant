require "spec_helper"

describe UserMailer do
	it "Sends welcome email" do
		user = User.create(:email=>"john@gmail.com")
		mail = UserMailer.welcome_email(user)
		mail.to[0].should eq(user.email)
		mail.subject.should eq("Welcome to CrowdAssistant")
	end
end
