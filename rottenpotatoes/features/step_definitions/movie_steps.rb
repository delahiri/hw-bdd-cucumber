# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end


Then /I should see "(.*)" before "(.*)"/ do |e1, e2|

  regexp = /#{e1}.*#{e2}/m  #m make dot match newlines
  expect(page.body).to match(regexp)
end


When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|

  rating_list.split(/,\s*/).each { |rating|
    if uncheck
      uncheck "ratings_#{rating}"
    else
      check "ratings_#{rating}"
    end
  }
end


Then /I should see all the movies/ do
  expect(page).to have_css("table#movies tbody tr", count: Movie.count)
end