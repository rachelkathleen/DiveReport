require 'pry'

class Scraper
  DIVE_REPORT_URL = "http://www.divereport.com/"

 def self.scrape_directory_animals
   html = open('http://www.divereport.com/site-directory/')
   doc = Nokogiri::HTML(open(html))

   doc.css("ul.sitemaplist li a")[0..30].each do |animal|
     binding.pry
     name = doc.css("ul.sitemaplist li a").text
     url = doc.css("ul.sitemaplist li a").attr("href").value
     Animal.new(name, url)
   end
  end
end


# animals = doc.css("ul.sitemaplist li a")[0..30]
# regions = doc.css("ul.sitemaplist li a")[31..43]
# countries = page.css("ul.sitemaplist li a")[44..125].text
