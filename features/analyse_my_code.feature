Feature:
	In order to analyse my code on kuniri
  As an user
  I want to see a link for analyse my code in home page of kuniri

  Scenario: Visualize analyse code page
		Given I am on the kuniri home page
		When I follow "Analyse_Code"
		Then I should be on analyse_code page
