require 'rails_helper'

    
 describe Movie do
  describe '.find_similar_movies' do
    let!(:movie1) { FactoryGirl.create(:movie, title: 'Star Wars', director: 'George Lucas') }
    let!(:movie2) { FactoryGirl.create(:movie, title: 'Blade Runner', director: 'Ridley Scott') }
    let!(:movie3) { FactoryGirl.create(:movie, title: 'Alien', director: 'Ridley Scott') }
    let!(:movie4) { FactoryGirl.create(:movie, title: 'THX-1138') }
     context 'director is present' do
      it 'finds movies with same directors' do
        expect(Movie.director_movies(movie2.title)).to eql(['Blade Runner','Alien'])
        expect(Movie.director_movies(movie1.title)).to_not include(['Blade Runner','Alien'])
        expect(Movie.director_movies(movie1.title)).to eql(['Star Wars'])
      end
    end
     context 'director is not present' do
      it 'for sad path' do
        expect(Movie.director_movies(movie4.title)).to eql(nil)
      end
    end
  end
  describe 'sorted and filter movies' do
    let!(:movie1) { FactoryGirl.create(:movie, title: 'Star Wars', director: 'George Lucas',rating:'PG') }
    let!(:movie2) { FactoryGirl.create(:movie, title: 'Blade Runner', director: 'Ridley Scott') }
    let!(:movie3) { FactoryGirl.create(:movie, title: 'Alien', director: 'Ridley Scott',rating:'PG') }
    let!(:movie4) { FactoryGirl.create(:movie, title: 'THX-1138') }
    it 'return sorted movies' do
    output=Array.new
     (Movie.fliter_ratings_order(['PG'],'title')).each do |movie|
       #print(movie.title)
       #print("######")
       #expect(movie.title).to eql(nil)
       output.append(movie.title)
    end
 #  print(output)
   expect(output).to eql(['Alien',"Star Wars"])
   end
   
   it 'retuns filter movies' do
   output=Array.new
   (Movie.fliter_ratings(['PG'])).each do |movie|
       #print(movie.title)
       #print("######")
       #expect(movie.title).to eql(nil)
       output.append(movie.title)
    end
 #  print(output)
   expect(output).to eql(['Star Wars','Alien'])
   end
   
  end
  
 describe 'should return all ratings' do
    it 'should see all ratings' do
      expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
    end
  end
end