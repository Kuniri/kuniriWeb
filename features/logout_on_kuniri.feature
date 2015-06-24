Feature:
	In order to realize logout on kuniri
	As an user
	I want to finish my session on kuniri

   Background: user in database
     
      Given the following user exists:
      | first_name   | last_name | email        | password | password_confirmation |
      | Lais         | Araujo    | lais@email   |   123    |  123                  |

Scenario: realize logout on kuniri
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Logout"
	Then I should see "Login"
	And I should see "Sign Up"
	And I should not see "Welcome, Lais!"
	And I should be on kuniri page
