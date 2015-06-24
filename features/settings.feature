Feature:
	In order to access settings on kuniri
	As an user
	I want to see the profile, history and delete account links

   Background: user in database
     
      Given the following user exists:
      | first_name   | last_name | email        | password | password_confirmation |
      | Lais         | Araujo    | lais@email   |   123    |  123                  |

Scenario: access settings on kuniri
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Settings"
	Then I should see "Profile"
	And I should see "History"
	And I should see "Delete Account"
	And I should be on settings page
