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

  def self.add_location_attributes(dive_location)
    dive_location_hash = Scraper.scrape_dive_location_details(dive_location)
    dive_location.description = dive_location_hash[:description]
    dive_location.visibility = dive_location_hash[:visibility]
    dive_location.water_temp = dive_location_hash[:water_temp]
    dive_location.area = dive_location_hash[:area]
  end

  def self.find_by_url(url)
   self.all.detect {|location| location.url == url}
  end

  def self.find_by_name(location_name)
    self.all.find {|location| location.name == location_name}
  end

  def self.find_by_name(country_name)
    self.all.find {|country| country.name == country_name}
  end

  def self.find_animals(animal)
    if Animal.locations.include?(self)
      DiveLocation.animals = animal
    end
  end
end
