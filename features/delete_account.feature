Feature:
	In order to don`t be part of kuniri anymore
	As an user
	I want to delete my account

   Background: user in database
     
      Given the following user exists:
      | first_name   | last_name | email        | password | password_confirmation |
      | Lais         | Araujo    | lais@email   |   123    |  123                  |

Scenario: access the delete account page and link
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Settings"
	And I follow "Delete Account"
	Then I should see " To delete your account, click on link below."
	Then I should see "Delete my account"
	And I should be on delete_account page

Scenario: delete account
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Settings"
	And I follow "Delete Account"
	And I follow "Delete my account"
	Then I should see "User account deleted with success!"
	Then I should be on kuniri page

Scenario: check deletion of user account
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Settings"
	And I follow "Delete Account"
	And I follow "Delete my account"
	And I follow "Login"
	And I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	Then I should see "User not find. Please register a new user"
