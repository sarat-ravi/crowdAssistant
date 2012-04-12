# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

set :output, "/app/log/cron_log.log"

every 1.minute do
	p "This is a running of the Task update"
	command "echo 'This is the scheduler.'", :environment => "development"
	runner "Assistant.update_all", :environment => "development"
end

# Learn more: http://github.com/javan/whenever
