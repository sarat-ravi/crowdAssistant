Feature: Login with facebook

  As a user
  So that I can use the site to get a personal assistant,
  I want to login with facebook credentials

  Scenario: click on login button
    Given I am on the home page
    When I follow "fb_button"
    Then I should be on the user page
