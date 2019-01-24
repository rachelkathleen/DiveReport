class DiveLocation
  attr_accessor :name, :url, :country, :description, :visibility, :depth_range

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
   self.all.detect{|country| country.url == url}.name
 end
end
