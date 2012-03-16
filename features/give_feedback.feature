Feature: Give feedback to the assistant 
  As a user
  So that I can give my assistants feedback
  I want to have a text field on the feedback page where I can type in and submit my input on the quality and completion of a task
 
  
Scenario: submit suggestions 
 Given I am on the "feedback" page
 And Given I am logged in as a user
 When I type "I was disappointed in task completion time" in the text box
 And I press submit
 Then I should be on the "support" page
 And I should see "Thanks for the input. We will take this into consideration."

Scenario: submit ratings 
 Given I am on the "feedback" page
 And Given I am logged in as a user
 When I type "I was disappointed in task completion time" in the text box
 And I rate with "5" stars
 Then I should be on the "support" page
 And I should see "Thank you for Rating me!"
