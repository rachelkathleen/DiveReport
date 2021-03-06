require 'pry'

class Animal
  attr_accessor :name, :url, :description, :locations

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @@all << self
    #binding.pry
  end

  def self.all
      @@all
  end

  def self.print_names
     self.all.each.with_index(1) {|animal, i| puts "#{i}. #{animal.name}"}
   end

   def self.description(animal)
     animal.description = Scraper.animal_details(animal)
   end

  def self.locations(animal)
    animal.locations = Scraper.divelocation_urls(animal)
  end

end
