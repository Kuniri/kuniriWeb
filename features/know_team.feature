Feature: 
	In order to know each member of developer team
	As an user
	I want to see a link in home page to know the developers


	Scenario: Visualize know developers
		Given I am on the kuniri home page
		When I follow "Team"
		Then I should be on team page
		#And I should see "kuniri" title
		#And I should see a brief explain "About Kuniri"
		


#Criação do link "conheça os desenvolvedores": Para quando o usuário apertar no link e ser direcionado para a página de perfis dos desenvolvedores