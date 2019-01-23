require 'pry'

class Scraper

  DIVE_REPORT_URL = "http://www.divereport.com/"

  # def self.scrape_animal_details(animal)
  #   html = open(DIVE_REPORT_URL + animal.url)
  #   doc = Nokogiri::HTML(html)
  #   animal.img_link = (find css selector)
  #   animal.locations = (find css selector - will be many locations)
  # end


  def self.scrape_directory_site
    html = open('http://www.divereport.com/site-directory/')
    doc = Nokogiri::HTML(open(html))

    objects = doc.css("ul.sitemaplist li a")
    objects.each.with_index do |nodeset, i|
      url = nodeset.attr("href")
      name = nodeset.text
      if i < 31
        Animal.new(name, url)
      elsif i < 44
        Region.new(name, url)
      elsif i < 126
        Country.new(name, url)
      else
        DiveLocations.new(name, url)
      end
    end
   end
  end



    # def self.scrape_animal_details(animal)
    #   html = open(DIVE_REPORT_URL + animal.url)
    #   doc = Nokogiri::HTML(html)
    #   animal.img_link = (find css selector)
    #   animal.locations = (find css selector - will be many locations)
    # end

# animals = doc.css("ul.sitemaplist li a")[0..30]
# regions = doc.css("ul.sitemaplist li a")[31..43]
# countries = page.css("ul.sitemaplist li a")[44..125].text
# dive location = selector = doc.css("ul.sitemaplist li a")[126..440].text
