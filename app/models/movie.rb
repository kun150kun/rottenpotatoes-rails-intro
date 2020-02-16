class Movie < ActiveRecord::Base
  def self.all_ratings
    @@all_ratings = Movie.uniq.pluck(:rating)
  end
  
  def self.with_rating(ratings)
    Movie.where(:rating => ratings)
  end
end
