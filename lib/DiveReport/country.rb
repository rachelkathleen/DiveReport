class Country
  attr_accessor :name, :url, :description, :dive_locations

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @@all << self
  end

  def self.all
      @@all
  end

  def self.print_names
     self.all.each.with_index(1) {|country, i| puts "#{i}. #{country.name}"}
   end
end
