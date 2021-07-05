class Baby
  require 'date'
  attr_accessor :name, :gender
  @@babies = []
  
  def initialize(name=nil)
    @name=name
    @@babies << self 
  end
  
  def birthday
    @birthday=Time.now.to_s
    puts "Date of birth: #{@birthday}"
    @birthday
  end
  
  def self.all_babies
    @@babies
  end
end