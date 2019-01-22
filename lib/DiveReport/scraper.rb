require 'pry'

class DiveReport::Scraper
  DIVE_REPORT_URL = "http://www.divereport.com/"

 def self.scrape_directory_animals
   html = open('http://www.divereport.com/site-directory/')
   doc = Nokogiri::HTML(open(html)

   doc.css("ul.sitemaplist li a")[0..30].each do |animal|
     name = doc.css("ul.sitemaplist li a").text
     url = doc.css("ul.sitemaplist li a").attr("href").value
     Animal.new(name, url)
     binding.pry
 end
end



# animals = doc.css("ul.sitemaplist li a")[0..30]
# regions = doc.css("ul.sitemaplist li a")[31..43]
# countries = page.css("ul.sitemaplist li a")[44..125].text
