require 'pry'

class Animal
  attr_accessor :name, :url, :img_link, :locations

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

   def show_info(animal)
     puts "#{animal.name}"
     puts "#{animal.img_link}"
     puts "#{animal.locations}"
   end
end
