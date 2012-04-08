
Feature: Update user profile

  As a user
  So that the assistant can view my profile
  I want to update my user profile

Background: user exists

  Given user exists
  |name     |email          |
  |John     |john@gmail.com |

  Given profile exists
  |user_id     |age          |pic_url          |gender  |address                           |phonenum    |
  |1           |20           |www.gravitar.com |Male    |University of California, Berkeley|1234567899 |
  

  And I am on the user page
  And I should see "John"
  And I should see "john@gmail.com" 
  And I should see "View Full Profile"
  And I should see "View Tasks"
  And I should see "Signed in as John!"

Scenario: can view profile
  Given I follow "View Full Profile"
  Then I should see "Age"
  Then I should see "Gender"
  Then I should see "Pic url"
  Then I should see "Address"
  Then I should see "Phone Number"
  Then I should see "University of California, Berkeley"
  Then I should see "Male"
  
Scenario: edit profile
  Given I follow "View Full Profile"
  Given I follow "Edit"
  Then I should see "Age"
  Then I should see "Gender"
  Then I should see "Picture Url"
  Then I should see "Address"
  Then I should see "Phone Number"
  When I fill in "profile_age" with "25"
  And I fill in "profile_gender" with "Female"
  And I press "Update Profile" 
  Then I should be on the profile page



