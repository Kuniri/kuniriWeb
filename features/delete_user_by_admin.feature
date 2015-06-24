Feature:
	In order to maintain controll about users
	As an admin of kuniri web
	I want to have permission of deletion about users accounts

   Background: admin in database
     
      Given the following user exists:
      | first_name   | last_name | email        | password | password_confirmation | admin |
      | Zezinho      | Santos    | ze@email     |   ze     |  ze                   | false |
      | Juninho      | Souza     | js@email     |   js     |  js                   | false |
      | Lais         | Araujo    | admin@admin  |   admin  |  admin                | true  |

Scenario: access kuniri users by admin
	Given I am on the login page
	When I fill in "Email" with "admin@admin"
	And I fill in "Password" with "admin"
	And I press "Log In"
	And I follow "Users"
	Then I should see "Zezinho"
	Then I should see "Juninho"
	Then I should see "delete"

Scenario: delete user
	Given I am on the login page
	When I fill in "Email" with "admin@admin"
	And I fill in "Password" with "admin"
	And I press "Log In"
	And I follow "Users"
	And I follow the second "delete" link
	Then I should see "User deleted with success!"
	And I should be on kuniri page

Scenario: check user deletion
	Given I am on the login page
	When I fill in "Email" with "admin@admin"
	And I fill in "Password" with "admin"
	And I press "Log In"
	And I follow "Users"
	And I follow the second "delete" link
	And I follow "Users"
	Then I should be on index page
	And I should not see "Zezinho"
