class Country
  attr_accessor :name, :url, :locations, :description

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

   def self.find_by_name(country_name)
  self.all.find {|country| country.name == country_name}
end
end
