Feature: Give feedback to the assistant 

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
