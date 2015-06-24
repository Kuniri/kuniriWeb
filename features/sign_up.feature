Feature:
	In order to cadastre me on kuniri
	As an user
	I want to see a sign up link in home page of kuniri

  Scenario: Visualize sign up code page
		Given I am on the kuniri page
		When I follow "Sign Up"
		Then I should be on sign_up page
