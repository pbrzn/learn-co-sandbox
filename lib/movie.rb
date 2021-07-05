require_relative "./scraper"

class Movie
  attr_accessor :name, :year, :genre, :runtime, :synopsis, :streamer, :url
  @@all=[]

  def initialize(basic_info)
    @name=basic_info[:name]
    @url=basic_info[:url]
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_by_streamer(streaming_service)
    library=Streamer.find_or_create_by_name(streaming_service)
    library.movies.each do |movie|
      if !self.find_by_name(movie.name)
        new_movie=Movie.new(movie)
        new_movie.add_attributes
        new_movie.streamer=library.name
        new_movie.save
      else
        movie.streamer="#{movie.streamer}, #{library.name}"
      end
    end
  end

  def add_attributes
    attributes=Scraper.movie_scraper(self.url)
    attributes.each do |k,v|
      self.send("#{k}=", v)
    end
    self
  end

  def self.find_by_name(name)
    self.all.find {|movie| movie.name==name}
  end

  def self.destroy_all
    self.all.clear
  end
end
