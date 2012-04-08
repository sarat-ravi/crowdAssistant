Feature: post task for an assistant to carry out

  As a user
  So That I can submit a job and have it completed by an assistant
  I want to go onto a site on the page and create a task

Background: user exists

  Given user exists
  |name     |
  |John     |

Scenario: submit a job 
  Given I am currently on the tasks page
  And I follow "New Task" 
  When I fill in "task_instructions" with "find me the first google result to rails"
  And I press "Create Task"
  Then I should be sent to the task page with id "1"
  And I should see "find me the first google result to rails"
  And I should see "Not Started"

