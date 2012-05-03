Feature: Check list of tasks

  As a user
  So that I can easily check the status of the tasks I have created 
  I want to see the statuses of my active tasks


Background: tasks have been added to database
  
  Given user exists
  |name     |
  |John     |
  And the following tasks exist:
  |user_id  | instructions             | status  | 
  |1        | task1                    | completed | 
  |1        | task2                    | completed | 
  |1        | task3                    | not started | 
  |1        | task4                    | completed |
  |1        | task5                    | pending |


Scenario: see all the tasks 
 Given I am currently on the tasks page 
 Then I should see "Listing tasks"
 And I should see "task1"
 And I should see "task3"
 And I should see "task2"
 And I should see "task4"
 And I should see "task5"

Scenario: see the status associated with each of the tasks 
 Given I am currently on the tasks page
 Then I should see "Listing tasks"
 And I should see "Status: Completed Task: task1"
 And I should see "Status: Completed Task: task2"
 And I should see "Status: Not Started Task: task3"
 And I should see "Status: Completed Task: task4"
 And I should see "Status: Pending Task: task5"

 And I should not see "Status: Not started Task: task1"
 And I should not see "Status: Pending Task: task2"
 And I should not see "Status: Completed Task: task3"
 And I should not see "Status: Not started Task: task4"
 And I should not see "Status: Completed Task: task5"