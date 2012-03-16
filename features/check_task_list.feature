Feature: Check list of tasks

  As a user
  So that I can easily check the status of the tasks I have created 
  I want to see the statuses of my active tasks

Scenario: stay up to date with tasks
 Given I am on the "status" page
 And Given I am logged in as a user
 Then I should see "Pending Tasks"
 And I should see "Completed Tasks"

Scenario: see details of pending
 Given I am on the "status" page
 And Given I am logged in as a user
 And I follow "Pending Tasks"
 Then I should not see "Completed Tasks"
