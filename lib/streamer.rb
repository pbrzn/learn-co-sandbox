require_relative './scraper'
require_relative './movie'

class Streamer
  attr_accessor :name, :movies
  @@all=[]

  def initialize(name)
    @name=name
    @movies=[]
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_or_create_by_name(name)
    if !self.all.find {|i| i.name==name}
      streamer = self.new(name)
      library = Scraper.streamer_scraper(name)
      library.each {|movie| streamer.movies << movie}
      Movie.create_by_streamer(name)
      #streamer
    else
      self.all.find {|i| i.name==name}
    end
  end

  def self.destroy_all
    self.all.clear
  end
end
