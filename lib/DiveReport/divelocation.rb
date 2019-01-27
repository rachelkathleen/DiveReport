require 'pry'
class DiveLocation
  attr_accessor :name, :url, :country, :description, :visibility, :depth_range, :water_temp, :area

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @@all << self
  end

  def self.all
      @@all
  end

  def self.find_by_url(url)
   self.all.detect {|location| location.url == url}.name
 end

  def self.find_by_name(location_name)
    self.all.find {|location| location.name == location_name}
  end

  def self.find_by_name(country_name)
    self.all.find {|country| country.name == country_name}
  end
end
