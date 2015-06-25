Feature:
	In order to update my profile on kuniri
	As an user
	I want to modify my informations and submit them

   Background: user in database
     
      Given the following user exists:
      | first_name   | last_name | email        | password | password_confirmation |
      | Lais         | Araujo    | lais@email   |   123    |  123                  |

Scenario: update profile on kuniri (update password)
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Settings"
	And I follow "Profile"
	And I fill in "Email" with "lais@email"
	And I fill in "Password" with "1234"
	And I fill in "Confirmation" with "1234"
	And I press "Save changes"
	Then I should see "Profile updated!"
	And I should be on settings page

Scenario: check updated information (old password given as invalid)
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Settings"
	And I follow "Profile"
	And I fill in "Email" with "lais@email"
	And I fill in "Password" with "1234"
	And I fill in "Confirmation" with "1234"
	And I press "Save changes"
	And I follow "Logout"
	And I follow "Login"
	And I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	Then I should see "Invalid email/password combination"
	And I should be on login page

Scenario: check updated information (new password allows realize login)
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Settings"
	And I follow "Profile"
	And I fill in "Email" with "lais@email"
	And I fill in "Password" with "1234"
	And I fill in "Confirmation" with "1234"
	And I press "Save changes"
	And I follow "Logout"
	And I follow "Login"
	And I fill in "Email" with "lais@email"
	And I fill in "Password" with "1234"
	And I press "Log In"
	Then I should see "Success on login"
	And I should see "Welcome, Lais!"
	And I should be on kuniri page

Scenario: check updated information (change old password for a new with different confirmation password)
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Settings"
	And I follow "Profile"
	And I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I fill in "Confirmation" with "1234"
	And I press "Save changes"
	Then I should see "Password do not match!"