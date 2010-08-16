Feature: Manage users
  In order to allow users to place lunch orders
  As an admin user
  I want to edit user balances

  Background:
    Given there is an admin user called "admin"
    And the following users:
      | login   | email            | first_name | last_name | password   | password_confirmation |
      | john    | john@example.com | John       | Doe       | secretpass | secretpass            |
      | paul    | paul@example.com | Paul       | Jones     | superpass  | superpass             |
      | mary_h  | mary@example.com | Marianne   | Hughes    | mypasswd   | mypasswd              |
    And I log in as user "admin"

#  Scenario: List users
#    When I go to the users page
#    Then show me the page
#    Then I should see the following users:
#      | Doe John           | john   | 0.00zł | | Edit Account | Remove Account |
#      | Hughes Marianne    | mary_h | 0.00zł | | Edit Account | Remove Account |
#      | Jones Paul         | paul   | 0.00zł | | Edit Account | Remove Account |
#      | last name 1 name 1 | admin  | 0.00zł | | Edit Account | Remove Account |

#  Scenario: Update user balance
#    Given I am on the users page
#    When I set balance for the 1st user to "10"
#    And I click "Update" for the 1st user
#    And I go to the users page
#    Then the 1st user balance should be "10"
#    Then I should see "10.00" for the 1st user
