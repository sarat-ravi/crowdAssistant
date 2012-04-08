# Add a declarative step here for populating the DB with tasks.

Given /user exists/ do |user_table|
  user_table.hashes.each do |user|
    user = User.create(:name => user[:name], :email => user[:email])
    #ession[:user_id] = user.id
    #controller.stub!(:current_user => user)
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
  Task.create(:user_id=> 1,:instructions => task[:instructions], :status => task[:status])
  end
end

Given /I am currently on the tasks page/ do
  #ApplicationController.stub!(:current_user=> User.first)
  visit path_to('the tasks page')
end

Then /I should be sent to the task page with id "(.*)"/ do |id|
  visit "/tasks/#{id}"
end


