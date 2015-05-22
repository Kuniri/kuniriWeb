Feature: 
	In order to contact the developers
	As an user
	I want to see the "contact us" page of the app

	Scenario: Visualize contact us Page
		Given I am on the kuniri home page
		When I follow "Contact us"
		Then I should be on contact page
