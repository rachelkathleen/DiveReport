class DiveReport::Animal
  attr_accessor :name, :url, :img_link, :locations

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @@all << self
  end

end
