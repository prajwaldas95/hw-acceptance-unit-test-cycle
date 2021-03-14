
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /^the director of "(.*)" should be "(.*)"$/ do |movie_name, director_val|
  movie = Movie.find_by_title(movie_name)
  visit movie_path(movie)
  expect(movie.director).to eq director_val
end


#When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
 # rating_list.split(', ').each do |rating|
  #  step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
##  end
#end


When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  result=page.body.scan(/<tr>/).count
  rating_list.split(/\s*,\s*/).each do |rating|
    if uncheck.nil?
      step %Q{I check "ratings_#{rating}"}
    else
      step %Q{I uncheck "ratings_#{rating}"}
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end


Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end





# Add a declarative step here for populating the DB with movies.






Then /(.*) seed movies should exist/ do | n_seeds |
  
  
  Movie.count.should be n_seeds.to_i
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
Then /I should see (\d+) movies$/ do |movie_count|
  result=page.body.scan(/<tr>/).length
  result=result-1
  result.should == movie_count.to_i
end


  


Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  index1=page.body.index(e1.to_s)
  index2=page.body.index(e2.to_s)
  (index1<index2).should be true
end
