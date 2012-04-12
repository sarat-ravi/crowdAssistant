desc "This task will be called by scheduler"
task :update_task => :environment do 
	p "Called Rake..."
	Assistant.update_all
	p "Done."
end
task :fetch_mail => :environment do
	p "Called Rake..."
	UserMailer.fetch_mail
end