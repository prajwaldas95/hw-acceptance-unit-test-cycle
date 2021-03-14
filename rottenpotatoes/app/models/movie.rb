class Movie < ActiveRecord::Base
  def self.all_ratings
    allRatings = ["G", "PG", "PG-13", "NC-17", "R"]
    return allRatings
  end
  def self.fliter_ratings(keys)
    return Movie.where(:rating =>keys)
  end
  def self.fliter_ratings_order(keys,sort_order)
    return Movie.where(:rating => keys).order(sort_order)
  end
 # def self.with_ratings(ratings_list)
 #   return Movie.where(rating: ratings_list)
 # end
  def self.director_movies(movie_title)
    director = Movie.find_by(:title => movie_title).director
    return nil if director.blank? or director.nil?
    Movie.where(:director => director).pluck(:title)
  end
end

