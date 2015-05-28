Feature:
	In order to contact every member of kuniri team
  As an user
  I want to see a profile for each member of kuniri team

  Scenario: Visualize profile of each team meamber page
		Given I am on the kuniri home page
		When I follow "Team"
		Then I should be on team page
		And I should see the name of each member
		And I should see the e-mail of each member
		And I should see the gitHub link of each member