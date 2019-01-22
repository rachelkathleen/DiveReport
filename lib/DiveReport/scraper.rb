class DiveReport::Scraper
  DIVE_REPORT_URL = "http://www.divereport.com/"

 def self.scrape_site_directory
   html = open('http://www.divereport.com/site-directory/')
   doc = Nokogiri::HTML(html)
 end
end
