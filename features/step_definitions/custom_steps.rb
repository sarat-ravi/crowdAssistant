# Add a declarative step here for populating the DB with tasks.

When /^I upload a file$/ do
  attach_file("path", File.join(Rails.root, 'public', 'robots.txt'))
end

And /^the task is completed$/ do
  task = Task.find_by_status("completed")
  UserMailer.task_finished(task).deliver
end

And /^I receive an email of a task$/ do
  UserMailer.incoming_task.deliver
end

Given /user exists/ do |user_table|
  user_table.hashes.each do |user|
    user = User.create(:name => user[:name], :email => user[:email])
  end
end

Given /profile exists/ do |profile_table|
  profile_table.hashes.each do |profile|
    profile = Profile.create(:user_id => profile[:user_id],
                            :age => profile[:age],
                            :gender => profile[:gender],
                            :pic_url => profile[:pic_url],
                            :address => profile[:address],
                            :phonenum => profile[:phonenum])
  end
end

Given /the following tasks exist/ do |tasks_table|
  tasks_table.hashes.each do |task|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that task to the database here.
  Task.create(:user_id=> 1,:instructions => task[:instructions], :status => task[:status], :answer => task[:answer])
  end
end

Given /I am currently on the tasks page/ do
  #ApplicationController.stub!(:current_user=> User.first)
  visit path_to('the tasks page')
end

Given /This feautre is pending .*/ do
  pending #
end

Then /I should be sent to the task page with id "(.*)"/ do |id|
  visit "/tasks/#{id}"
end


