Feature: 
	In order to login in kuniri
	As an user
	I want to see a link login in home page of kuniri

	Scenario: Visualize login page
		Given I am on the kuniri page
		When I follow "Login"
		Then I should be on login page
