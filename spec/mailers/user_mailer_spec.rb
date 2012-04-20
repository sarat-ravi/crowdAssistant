require "spec_helper"
describe UserMailer do
	it "Sends welcome email" do
		user = User.create(:email=>"john@gmail.com")
		mail = UserMailer.welcome_email(user)
		mail.to[0].should eq(user.email)
		mail.subject.should eq("Welcome to CrowdAssistant")
	end
	it "Sends notification for task completion" do
		user = User.create(:email=>"john@gmail.com")
		task = Task.create(:user_id => user.id, :instructions => "What is the weather in Berkeley", :answer => "The weather is wonderful")
		mail = UserMailer.task_finished(task)
		mail.to[0].should eq(user.email)
		mail.subject.should eq("Your task has completed")
	end
end
