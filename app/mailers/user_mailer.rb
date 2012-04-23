require 'net/http'
require 'net/imap'

class UserMailer < ActionMailer::Base
  default from: "CrowdAssistant@gmail.com"
  def welcome_email(user)
  	@user = user
  	mail(:to => user.email, :subject => "Welcome to CrowdAssistant")
  end

  #Send Task notification on completion
  def task_finished(task)
    @task = task
    @user = User.find(@task.user_id)
    mail(:to => @user.email, :subject => "Your task has completed")
  end

  def incoming_task
    mail(:to => "CrowdAssistant@gmail.com", :subject => "Task", :from => "john@gmail.com")
  end

  #Receive email and save as tasks
  def fetch_mail
#  	p "Fetching mail..."
  	config = { :host => 'imap.gmail.com', :port => 993, :username => 'CrowdAssistant', :password => 'CrowdAss'}
  	imap = Net::IMAP.new(config[:host], config[:port], true)
  	imap.login(config[:username], config[:password])
  	imap.select("INBOX")
  	messages_to_archive = []
  	imap.search(["NOT", "DELETED"]).each do |message_id|
  		task = imap.fetch(message_id, 'BODY[TEXT]')[0].attr['BODY[TEXT]']
  		message = imap.fetch(message_id, 'ENVELOPE')[0].attr['ENVELOPE']
  		from = "#{message.sender[0].mailbox}@#{message.sender[0].host}"
#      p from
  		u = User.find_by_email(from)
#      p u
  		if u
	  		#Why does an empty resource and resourcetype fail?
	  		t = Task.create(:user_id => u.id, :instructions => task, :fields => "[{\"Reply\":\"t\"}]", :priority => 2, :workflow => "p", :redundancy => 2, :resource => "www.google.com", :resourcetype => "l")
	  		Assistant.handle(t)
	  	else
#	  		p "Whoops, some dude who hasn't signed up sent us an email"
	  	end
  		messages_to_archive << message_id
  	end
   	imap.store(messages_to_archive, "+FLAGS", [:Deleted]) unless messages_to_archive.empty?
  end
end