Feature:
	In order to obtain a documentation about my code
	As an user
	I want to analyse my code on kuniri

   Background: user in database
     
      Given the following user exists:
      | first_name   | last_name | email        | password | password_confirmation |
      | Lais         | Araujo    | lais@email   |   123    |  123                  |

Scenario: access the analyse code page
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Analyse Code"
	Then I should be on analyse_code page

Scenario: submit a github project to be analysed
	Given I am on the login page
	When I fill in "Email" with "lais@email"
	And I fill in "Password" with "123"
	And I press "Log In"
	And I follow "Analyse Code"
	And I fill in "GitHub link of project" with "https://github.com/cotrim149/kuniriWeb"
	And I press "Submit project"
	Then I should see "Project analysed with success!"
	Then I should be on kuniri page
