require 'pry'

class Scraper

  DIVE_REPORT_URL = "http://www.divereport.com/"

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
        DiveLocation.new(name, url)
      end
    end
   end


     def self.scrape_animal_details(animal)
       html = open(DIVE_REPORT_URL + animal.url)
       doc = Nokogiri::HTML(html)
       animal.description = doc.css(".animale p")[0..1].text
       divelocation_url = doc.css("div.searchResults ul li a.searchResultHeader").attr("href").value
       animal.locations = []
       animal.locations << DiveLocation.url(divelocation_url)
     end
  end

  #doc.css("div.searchResults ul li a.searchResultHeader").attr("href").value is the CSS selector for the url of the dive location.
