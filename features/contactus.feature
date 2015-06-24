Feature: 
	In order to contact the developers
	As an user
	I want to see the "contact" page of the app

	Scenario: Visualize contact us Page
		Given I am on the kuniri page
		When I follow "Contact"
		Then I should be on contact page
