require 'pry'

class Scraper

  DIVE_REPORT_URL = "http://www.divereport.com/"

 def self.scrape_directory_animals
   html = open('http://www.divereport.com/site-directory/')
   doc = Nokogiri::HTML(open(html))

   animals = doc.css("ul.sitemaplist li a")[0..30]
   animals.each do |nodeset|
     url = nodeset.attr("href")
     name = nodeset.text
     Animal.new(name, url)
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
