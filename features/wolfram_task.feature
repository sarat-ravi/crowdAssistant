Feature: post task for wolfram api if possible

  As a user
  So That I can get quick and accurate answers to queries that Wolfram can answer
  I want the task to be sent to Wolfram|alpha and be managed by CrowdAssistant 

Background: user exists

  Given user exists
  |name     |
  |John     |

Scenario: submit a job through Wolfram|alpha from tasks page 
  Given I am currently on the tasks page
  And I follow "New Task" 
  When I fill in "task_instructions" with "pi"
  And I press "Create Task"
  Then I should be sent to the task page with id "1"
  And I should see "Decimal approximation"
  And I should see "pi"
  And I should see "done"

Scenario: submit a job through Wolfram|alpha from home page 
  Given I am on the home page
  When I fill in "task_bar" with "planks constant"
  And I press "Create Task"
  Then I should be sent to the task page with id "1"
  And I should see "Value"
  And I should see "Interpretation"
  And I should see "planks constant"
  And I should see "done"

