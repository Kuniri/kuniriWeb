Feature: 
	In order to know about kuniri
	As an user
	I want to see the home page of the app


	Scenario: Visualize Home Page
		Given I am on the KinuriWeb home page
		When I follow "Home"
		Then I should be on KinuriWeb home page
		And I should see "KinuriWeb"


