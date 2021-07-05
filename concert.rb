class Concert
  attr_accessor :venue, :location, :name
  @@all = []
  
  def self.all
    @@all
  end
  
  def save
    @@all << self
  end
  
  def self.create
    show=self.new
    show.save
    show
  end
  
  def self.create_with_data(name, venue=nil, location=nil)
    show=self.create
    @name=name
    @venue=venue
    @location=location
    show.name=name
    show.venue=venue
    show.location=location
    show
  end
  
  def self.find_by_location(location)
    @@all.find {|concert| concert.location == location}
  end
  
  def self.find_all_by_location(location)
    @@all.find_all {|concert| concert.location == location}
  end
end