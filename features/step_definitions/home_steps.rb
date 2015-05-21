Given /^(?:|I )am on the (.+) home page$/ do |page_name|
  visit "/#{page_name}"
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

Then /^(?:|I )should be on (.+) home page$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == "/#{page_name}"
  else
    assert_equal "/#{page_name}", current_path
  end
end

And /^(?:|I )should see "([^"]*)" title$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

And /^(?:|I )should see a brief explain "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end 


