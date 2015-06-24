Feature:
	In order to realize login on kuniri
	As an user
	I want to enter with my email and my password to access my account

   Background: user in database
     
      Given the following user exists:
      | first_name   | last_name | email        | password | password_confirmation |
      | Lais         | Araujo    | lais@email   |   123    |  123                  |

Scenario: realize login on kuniri
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	Then I should see "Success on login"
	And I should see "Welcome, Lais!"
	And I should be on kuniri page
