class Region
  attr_accessor :name, :url, :countries, :locations

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
     self.all.each.with_index(1) {|region, i| puts "#{i}. #{region.name}"}
  end
end
