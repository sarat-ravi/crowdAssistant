Feature: Payment

  As a user
  So that I can buy credits to use on Tasks
  I want to be able to enter my credit card information and charge it.

Background: User exists and has no balance
  
  Given user exists
  |name     |balance |
  |John     |0		 |
@wip
Scenario: Charge credit card 
 Given I am on the user page 
 And I follow "Add More Credits"
 Then I should be on the payment page
 When I fill in "amount" with "10"
 And I fill in "card-number" with "4242424242424242"
 And I fill in "card-cvc" with "123"
 And I select "1" from "card-expiry-month"
 And I select "2013" from "card-expiry-month"
 And I press "Submit Payment"
 Then I should be on  the user page
 And I should see "$10"