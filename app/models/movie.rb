class Movie < ActiveRecord::Base
  @@checked_ratings = Movie.uniq.pluck(:rating)
  def self.checked_ratings
    @@checked_ratings
  end
  
  def self.checked_ratings=(ratings)
    @@checked_ratings=ratings
  end
    
  def self.all_ratings
    @@all_ratings = Movie.uniq.pluck(:rating)
  end
  
  def self.with_rating(ratings)
    Movie.where(:rating => ratings)
  end
end
