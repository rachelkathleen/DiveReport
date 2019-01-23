class DiveLocation
  attr_accessor :name, :url, :country

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
   self.all.select{|country| country.url == url}
 end
end
