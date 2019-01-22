require 'pry'

class Animal
  attr_accessor :name, :url, :img_link, :locations

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @@all << self
  end

  def self.all
      @@all
  end
end
