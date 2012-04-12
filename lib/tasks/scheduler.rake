desc "This task will be called by scheduler"
task :update_task => :environment do 
	p "Called Rake..."
	Assistant.update_all
	p "Done."
end
task :fetch_mail do
	p "Called Rake..."
end