Feature: Manage orders
  In order to have lunch
  As a logged in user
  I want to place and manage orders

  Background:
    Given there is a vendor called "MyVendor"
    And the following lunches for now:
      | vendor_id | name | description |
      | 1         | A    | Pizza       |
      | 1         | B    | Chicken     |
    And there is a user called "john"
    And user "john" has the balance equal to 100
    And I log in as user "john"
    
  Scenario: List lunches to order
    Given I am on the new order page
    Then I should see the following lunches:
      | MyVendor | A | Pizza   | 5.00zł |
      | MyVendor | B | Chicken | 5.00zł |
    And I should see "Current balance: 100.00"

  Scenario: List orders
    Given the following orders:
      | lunch_id | user_id | total |
      | 1        | 1       | 5.0   |
      | 2        | 1       | 10.0  |
    When I go to my orders page
    Then I should have 2 orders for the current date
    And I should see "Pizza" within "table"
    And I should see "Chicken" within "table"
  
  Scenario: Create new order
    Given I have 0 orders for the current date
    And system is unlocked
    And I am on the new order page
    When I choose "Pizza" from the lunches list
    And I press "Order"
    Then I should see "Lunch ordered!"
    And I should be on my orders page
    And I should see "Current balance: 95.00"
    And I should have 1 order for the current date
    And it should be named "Pizza"
    
  Scenario: Disable ordering when system is locked
    Given system is locked
    When I am on the new order page
    Then should see "System Locked"
    And the radio button for "Pizza" should be disabled
    And the radio button for "Chicken" should be disabled
#    And the submit button should be disabled

  Scenario: Delete non-refunded order
    Given lunches are refundable by 5
    And there is 1 refundable lunch per day
    And the following orders:
      | lunch_id | user_id | total |
      | 1        | 1       | 5.0   |
      | 2        | 1       | 10.0  |
    And I am on my orders page
    And I should see "Current balance: 85.00"
    When I delete the 2nd order
    Then I should see the following orders:
      | MyVendor | A | Pizza | 5.00zł | new | Cancel order |
    And I should see "Current balance: 95.00"
    And I should see "Order removed!"

  Scenario: Delete refunded order
    Given lunches are refundable by 5
    And there is 1 refundable lunch per day
    And the following orders:
      | lunch_id | user_id | total |
      | 1        | 1       | 5.0   |
      | 2        | 1       | 10.0  |
    And I am on my orders page
    And I should see "Current balance: 85.00"
    When I delete the 1st order
    Then I should see the following orders:
      | MyVendor | B | Chicken | 5.00zł | new | Cancel order |
    And I should see "Current balance: 95.00"
    And I should see "Order removed!"

  Scenario: Delete all orders
    Given lunches are refundable by 5
    And there is 1 refundable lunch per day
    And the following orders:
      | lunch_id | user_id | total |
      | 1        | 1       | 5.0   |
      | 2        | 1       | 10.0  |
      | 2        | 1       | 10.0  |
      | 1        | 1       | 10.0  |
      | 1        | 1       | 10.0  |
      | 2        | 1       | 10.0  |
    And I am on my orders page
    And I should see "Current balance: 45.00"
    When I delete the 6th order
    And I delete the 5th order
    And I delete the 1st order
    And I delete the 3rd order
    And I delete the 2nd order
    And I delete the 1st order
    Then I should have 0 orders for the current date
    And I should see "Current balance: 100.00"
    And I should see "Order removed!"
    
  Scenario: Cannot delete complete order
    Given the following orders:
      | lunch_id | user_id | total | complete |
      | 1        | 1       | 5.0   | true     |
    When I go to my orders page
    Then I should not see "Cancel order" within "tbody"

  Scenario: Cannot delete order when system is locked
    Given the following orders:
      | lunch_id | user_id | total | complete |
      | 1        | 1       | 5.0   | false    |
    And system is locked
    When I go to my orders page
    Then I should not see "Cancel order" within "tbody"

  Scenario: More than 1 refunded lunch per day
    Given lunches are refundable by 5
    And there are 3 refundable lunches per day
    And I am on the new order page
    When I choose "Pizza" from the lunches list
    And I press "Order"
    And I go to the new order page
    And I choose "Pizza" from the lunches list
    And I press "Order"
    And I go to the new order page
    And I choose "Chicken" from the lunches list
    And I press "Order"
    And I go to the new order page
    And I choose "Pizza" from the lunches list
    And I press "Order"
    Then I should see "Lunch ordered!"
    And I should be on my orders page
    And I should have 4 orders for the current date
    And I should see "Current balance: 75.00"
