Feature: post task for an assistant to carry out

  As a user
  So That I can submit a job and have it completed by an assistant
  I want to go onto a site on the page and create a task and also be able to delete it later

Scenario: submit a job 
  Given I am on the "create query" page
  When I type "find me the first google result to rails" in the text box
  And I press submit
  Then I sould be on the "pending tasks" page
  And I should see "job status"

Scenario: delete a job 
  Given I am on the "pending tasks" page
  When I select "All jobs"
  And I press Delete
  Then I sould be on the "pending tasks" page
  And I should see "you have no pending tasks"
