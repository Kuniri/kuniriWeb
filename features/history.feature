Feature:
	In order to see my analysed codes
	As an user
	I want to access my history page

   Background: user in database
     
      Given the following user exists:
      | first_name   | last_name | email        | password | password_confirmation |
      | Lais         | Araujo    | lais@email   |   123    |  123                  |

Scenario: access the history page
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Analyse Code"
	And I fill in "GitHub link of project" with "https://github.com/cotrim149/kuniriWeb"
	And I press "Submit project"
	And I follow "Settings"
	And I follow "History"
	Then I should see "kuniriWeb"
	Then I should see "https://github.com/cotrim149/kuniriWeb"
	Then I should see "Class Diagram"
	Then I should see "Analysis Date"

Scenario: access class diagram by history table
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Analyse Code"
	And I fill in "GitHub link of project" with "https://github.com/cotrim149/kuniriWeb"
	And I press "Submit project"
	And I follow "Settings"
	And I follow "History"
	And I follow "Show"
	Then I should be on analyse_code page