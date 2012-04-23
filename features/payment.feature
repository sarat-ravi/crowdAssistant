Feature: Payment

  As a user
  So that I can buy credits to use on Tasks
  I want to be able to enter my credit card information and charge it.

Background: User exists and has no balance
  
  Given user exists
  |name     |balance |
  |John     |100		 |

  Given profile exists
  |user_id     |age          |pic_url          |gender  |address                           |phonenum    |
  |1           |20           |www.gravitar.com |Male    |University of California, Berkeley|1234567899 |

@javascript
Scenario: Charge credit card  with all valid information
 Given I am on the user page
 Then I should see "John $1.00"
 And I follow "Charge Card"
 Then I should be on the payment page
 When I fill in "amount" with "100"
 And I fill in "card-number" with "4242424242424242"
 And I fill in "card-cvc" with "123"
 And I select "1" from "card-expiry-month"
 And I select "2013" from "card-expiry-year"
 And I press "Buy"
 Then I should be on the payment page
 Then I should not see "John $1.00"

@javascript
Scenario: Charge credit card with no information
 Given I am on the user page 
 And I follow "Charge Card"
 Then I should be on the payment page
 And I press "Buy"
 Then I should be on the payment page
 Then I should see "Your card number is invalid"

@javascript
Scenario: Charge credit card with wrong credit card number
 Given I am on the user page 
 And I follow "Charge Card"
 Then I should be on the payment page
 When I fill in "amount" with "100"
 And I fill in "card-number" with "4242424242424241"
 And I fill in "card-cvc" with "123"
 And I select "1" from "card-expiry-month"
 And I select "2013" from "card-expiry-year"
 And I press "Buy"
 Then I should be on the payment page
 Then I should see "Your card number is incorrect"

@javascript
Scenario: Charge credit card with early expiration
 Given I am on the user page 
 And I follow "Charge Card"
 Then I should be on the payment page
 When I fill in "amount" with "100"
 And I fill in "card-number" with "4242424242424242"
 And I fill in "card-cvc" with "123"
 And I select "1" from "card-expiry-month"
 And I select "2012" from "card-expiry-year"
 And I press "Buy"
 Then I should be on the payment page
 Then I should see "Your card's expiration month is invalid"


@javascript
Scenario: Charge credit card with no ccv code
 Given I am on the user page 
 And I follow "Charge Card"
 Then I should be on the payment page
 When I fill in "amount" with "100"
 And I fill in "card-number" with "4242424242424242"
 And I select "1" from "card-expiry-month"
 And I select "2013" from "card-expiry-year"
 And I press "Buy"
 Then I should be on the payment page
 Then I should see "Your card's security code is invalid"