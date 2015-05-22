Feature: 
	In order to know about kuniri
	As an user
	I want to see the home page of the app


	Scenario: Visualize Home Page
		Given I am on the kuniri home page
		When I follow "Home"
		Then I should be on kuniri page
		And I should see "kuniri" title
		And I should see a brief explain "About Kuniri"


