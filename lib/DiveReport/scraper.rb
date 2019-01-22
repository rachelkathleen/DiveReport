require 'pry'

class Scraper

  DIVE_REPORT_URL = "http://www.divereport.com/"

 def self.scrape_directory_animals
   html = open('http://www.divereport.com/site-directory/')
   doc = Nokogiri::HTML(open(html))

   urls_array = doc.css("ul.sitemaplist li a")[0..30].map{|url| url.attr("href")}
   names_array = doc.css("ul.sitemaplist li a")[0..30].map{|name| name.text}

   Animal.new(name, url)
  end
end




# animals = doc.css("ul.sitemaplist li a")[0..30]
# regions = doc.css("ul.sitemaplist li a")[31..43]
# countries = page.css("ul.sitemaplist li a")[44..125].text
