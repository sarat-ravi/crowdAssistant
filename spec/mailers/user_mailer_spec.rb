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
	describe "fetches email"
		before(:each) do
			config = { :host => 'imap.gmail.com', :port => 993, :username => 'CrowdAssistant', :password => 'CrowdAss'}
			@imap = Net::IMAP.new(config[:host], config[:port], true)
			@imap.login(config[:username], config[:password])
			@imap.select("INBOX") 
		end
		it "receives email and it's emtpy" do
			UserMailer.fetch_mail
			Assistant.should_not_receive(:handle)
		end
		it "receives email and it has an email!!" do
			allow_message_expectations_on_nil()
			user = User.create(:email => "john@gmail.com")
			task = Task.create(:user_id => user.id, :resource => "www.google.com")
			message, header, attrs, hash = nil, nil, nil, nil
			array = []
			Net::IMAP.any_instance.stub(:search).and_return([1])
			Net::IMAP.any_instance.stub(:fetch).and_return(message)
			message.stub!(:sender).and_return(array)
			message.stub!(:[]).and_return(attrs)
			attrs.stub!(:attr).and_return(hash)
			hash.stub!(:[]).and_return(message)
			array.stub!(:[]).and_return(header)
			header.stub!(:mailbox).and_return("john")
			header.stub!(:host).and_return("gmail.com")
			message.stub!(:gsub).and_return(message)

			User.should_receive(:find_by_email).with("john@gmail.com").and_return(user)
			Task.should_receive(:create).and_return(task)
			Assistant.should_receive(:handle).with(task)
			UserMailer.fetch_mail
		end
		it "receives email from a stranger" do
			allow_message_expectations_on_nil()
			user = User.create(:email => "john@gmail.com")
			task = Task.create(:user_id => user.id, :resource => "www.google.com")
			message, header, attrs, hash = nil, nil, nil, nil
			array = []
			Net::IMAP.any_instance.stub(:search).and_return([1])
			Net::IMAP.any_instance.stub(:fetch).and_return(message)
			message.stub!(:sender).and_return(array)
			message.stub!(:[]).and_return(attrs)
			attrs.stub!(:attr).and_return(hash)
			hash.stub!(:[]).and_return(message)
			array.stub!(:[]).and_return(header)
			header.stub!(:mailbox).and_return("joe")
			header.stub!(:host).and_return("gmail.com")
			User.should_receive(:find_by_email).with("joe@gmail.com").and_return(nil)
			Task.should_not_receive(:create)
			Assistant.should_not_receive(:handle)
			UserMailer.fetch_mail
		end
end
