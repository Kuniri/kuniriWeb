
Then(/^I should see the (.*) of each member$/) do |word|
	
	if word == "name"
		words = ["Lais", "Rodrigo", "Victor"]
	elsif word == "e-mail"
		words = ["lais_barreto92@hotmail.com", "rodrigomelosiqueira@gmail.com", "cotrim149@gmail.com"]
	elsif word == "gitHub link"
		words = ["GitHub_Profile"]
	end

	words.each do |text|
		if page.respond_to? :should
			page.should have_content(text)
		end		
	end


end
