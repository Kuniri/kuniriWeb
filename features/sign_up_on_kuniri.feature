Feature: sign up on kuniri web

	In order to cadastre me on kuniri web
	As an user
	I want to fill the fields with my informations and submit them

Scenario: Submit informations by sign up form
	Given I am on the sign_up page
	When I fill in "First name" with "Lais"
	And I fill in "Last name" with "Araujo"
	And I fill in "Email" with "lais@email"
	And I fill in "password" with "123"
	And I fill in "password confirmation" with "123"
	And I press "Create an account"
	Then I should see "Welcome, Lais!"
	And I should be on kuniri page
