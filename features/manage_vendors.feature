Feature: Manage vendors
  In order to create menus
  As an admin user
  I want to create and edit lunch vendors list

  Background:
    Given there is an admin user called "admin"
    And I log in as user "admin"

  Scenario: List vendors
    Given the following vendors:
      | name         |
      | Napoli Pizza |
      | Hot Ribs BBQ |
      | 3 vendor     |
    And the following lunches for right now:
      | vendor_id | name | description |
      | 1         | A    | Pizza       |
      | 3         | B    | Chicken     |
    And the following orders:
      | lunch_id | user_id | total | complete |
      | 1        | 1       | 5.0   | false    |
      | 2        | 1       | 5.0   | false    |
    And notification was sent for "3 vendor" now
    When I go to the vendors page
    Then I should see the following vendors:
      | Napoli Pizza | Edit | Remove | 1 order for today  | Mark orders as complete  | Send e-mail notification                         |
      | Hot Ribs BBQ | Edit | Remove | 0 orders for today |                          | Send e-mail notification                         |
      | 3 vendor     | Edit | Remove | 1 order for today  | Mark orders as complete  | Notification already sent today, click to resend |
    And I should see "Add vendor"

  Scenario: Send email notification
    Given the following vendors:
      | name         |
      | Napoli Pizza |
      | Hot Ribs BBQ |
      | 3 vendor     |
    And I am on the vendors page
    And I should not see "Notification already sent today, click to resend" for the 1st vendor on the list
    When I click "Send e-mail notification" for the 1st vendor on the list
    Then I should see "Notification already sent today, click to resend" for the 1st vendor on the list
    
  Scenario: Mark orders as complete
    Given the following vendors:
      | name         |
      | Napoli Pizza |
      | Hot Ribs BBQ |
      | 3 vendor     |
    And the following lunches for right now:
      | vendor_id | name | description |
      | 1         | A    | Pizza       |
      | 3         | B    | Chicken     |
    And the following orders:
      | lunch_id | user_id | total | complete |
      | 1        | 1       | 5.0   | false    |
      | 2        | 1       | 5.0   | false    |
    And I am on the vendors page
    And I should not see "Mark orders as new" for the 1st vendor on the list
    When I click "Mark orders as complete" for the 1st vendor on the list
    Then orders for "Pizza" for right now should be complete
    And I should see "Mark orders as new" for the 1st vendor on the list

  Scenario: Mark orders as incomplete
    Given the following vendors:
      | name         |
      | Napoli Pizza |
      | Hot Ribs BBQ |
      | 3 vendor     |
    And the following lunches for right now:
      | vendor_id | name | description |
      | 1         | A    | Pizza       |
      | 3         | B    | Chicken     |
    And the following orders:
      | lunch_id | user_id | total | complete |
      | 1        | 1       | 5.0   | true     |
      | 2        | 1       | 5.0   | true     |
    And I am on the vendors page
    And I should not see "Mark orders as complete" for the 1st vendor on the list
    When I click "Mark orders as new" for the 1st vendor on the list
    Then orders for "Pizza" for right now should be incomplete
    And I should see "Mark orders as complete" for the 1st vendor on the list

  Scenario: Add vendor
    Given I have 0 vendors
    And I am on the vendors page
    When I follow "Add vendor"
    And I fill in "Name" with "My new vendor"
    And I press "Add"
    Then I should see "Vendor added!"
    And I should have 1 vendor
  
  Scenario: Delete vendor
    Given the following vendors:
      | name         |
      | Napoli Pizza |
      | Hot Ribs BBQ |
      | 3 vendor     |
    When I go to the vendors page
    And I delete the 2nd vendor
    Then I should see "Vendor removed!"
    And I should have 2 vendors
    
  Scenario: Edit vendor
    Given the following vendors:
      | name         |
      | Napoli Pizza |
      | Hot Ribs BBQ |
      | 3 vendor     |
    When I go to the vendors page
    And I edit the 3rd vendor
    And I fill in "Name" with "Xtreme Chinese"
    And I press "Update"
    Then I should see "Vendor info updated!"
    And the 3rd vendor should be named "Xtreme Chinese"

  Scenario: Delete vendor with unavailable lunches without orders
    Given there is a vendor called "Napoli Pizza"
    And the following lunches for yesterday:
      | vendor_id | name | description |
      | 1         | A    | Pizza       |
      | 1         | B    | Chicken     |
    When I go to the vendors page
    And I delete the 1st vendor
    Then I should see "Vendor removed!"
    And I should have 0 vendors
    And I should have 0 lunches

  Scenario: Delete vendor with available lunches without orders
    Given there is a vendor called "Napoli Pizza"
    And the following lunches for today:
      | vendor_id | name | description |
      | 1         | A    | Pizza       |
      | 1         | B    | Chicken     |
    When I go to the vendors page
    And I delete the 1st vendor
    Then I should see "Vendor removed!"
    And I should not see "Napoli Pizza"
    And I should have 0 lunches
    And I should have 0 vendors

  Scenario: Delete vendor with available lunches with incomplete orders
    Given there is a vendor called "Napoli Pizza"
    And the following lunches for today:
      | vendor_id | name | description |
      | 1         | A    | Pizza       |
      | 1         | B    | Chicken     |
    And the following orders:
      | lunch_id | user_id | total | complete |
      | 1        | 1       | 5.0   | false    |
    When I go to the vendors page
    And I delete the 1st vendor
    Then I should see "Vendor removed!"
    And I should not see "Napoli Pizza"
    And I should have 0 vendors
    And I should have 0 lunches
    And I should have 0 orders

  Scenario: Hide vendor with unavailable lunches with orders destroying lunches without orders
    Given there is a vendor called "Napoli Pizza"
    And the following lunches for 3 weeks ago:
      | vendor_id | name | description |
      | 1         | A    | Pizza       |
      | 1         | B    | Chicken     |
    And the following lunches for today:
      | vendor_id | name | description |
      | 1         | A    | Pasta       |
      | 1         | B    | Ravioli     |
    And the following orders:
      | lunch_id | user_id | total | complete |
      | 1        | 1       | 5.0   | true     |
    When I go to the vendors page
    And I delete the 1st vendor
    Then I should see "Vendor removed!"
    And I should not see "Napoli Pizza"
    And I should have 1 order
    And I should have 1 lunch
    And I should have 1 vendors
