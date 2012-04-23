Feature: Email

  As a user
  So that I can easily and quickly add and get notified of tasks,
  I want to be able to send and receive messages to/from CrowdAssistant@gmail.com

Background: User exists and a task is completed
  
  Given user exists
  |name     | email 		    	    |
  |John     | CrowdAssistant@gmail.com  | 


  And the following tasks exist:
  |user_id  | instructions             | status    | answer   |
  |1        | This is the task         | completed | Response |

  Scenario: Send an email on completion of a task
  	Given no emails have been sent
  	And the task is completed
  	Then they should receive an email
  	And they should receive an email with subject "Your task has completed"
  	And they open the email
  	Then they should see "This is the task" in the email body
  	And they should see "Response" in the email body

  Scenario: Receive an email of a task
  	Given no emails have been sent
  	And I receive an email of a task
  	Then I should receive an email
  	And I should receive an email with subject "Task"
  	And I open the email
  	And I should see the email delivered from "john@gmail.com"
  	Then I should see "This is the task" in the email body
