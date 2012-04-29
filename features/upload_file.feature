Feature: Allow user to upload a file

  As a user
  So that I can send much more information with my task
  I want to be able to upload an image, or a document that relates to my task.

Background: user exists

  Given user exists
  |name     |
  |John     |

@wip
Scenario: upload a file
  Given I am currently on the home page
  And I press "Upload File"
  And I select "businesscard.jpg"
  Then I should be on the home page
  And I should see "businesscard.jpg"

@wip
Scenario: send the file as a resource
  Given I am currently on the home page
  And I press "Upload File"
  And I select "businesscard.jpg"
  Then I should be on the home page
  And I should see "businesscard.jpg"
  And I fill in "task_bar" with "Type up this business card"
  And I press "Create Task"
  Then I should be sent to the task page with id "1"
  And I should see "Type up this business card"
  And I should see "Not Started"