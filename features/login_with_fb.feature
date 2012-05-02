Feature: Login with facebook

  As a user
  So that I can use the site to get a personal assistant,
  I want to login and logout with facebook credentials

@omniauth_test
  Scenario: clicking on login button will get us back to home page
  	Given I am on the home page
  	When I follow "fb_button"
  	Then I should see "Signed in!"
  	And I should be on the home page

@omniauth_test
  Scenario: clicking on logout button will sign me out
  	Given user exists
  	|name     |
  	|John     |
  	And I am on the home page
  	Then I should see "Sign Out"
  	When I follow "Sign Out"
  	Then I should see "Signed out!"
  	And I should be on the home page