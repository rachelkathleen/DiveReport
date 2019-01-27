require 'pry'

class Scraper

  DIVE_REPORT_URL = "http://www.divereport.com/"

  def self.get_page(object)
   Nokogiri::HTML(open(DIVE_REPORT_URL + object.url))
  end

  def self.scrape_directory_site
    html = open('http://www.divereport.com/site-directory/')
    page = Nokogiri::HTML(open(html))

    objects = page.css("ul.sitemaplist li a")
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

  def self.animal_details(animal)
    page = self.get_page(animal)
    animal.description = page.css(".animale p")[0].text
  end

  def self.region_details(region)
    page = self.get_page(region)
    countries = []
    page.css(".MainAndOffside div.TabCol h1").each {|country| countries << country.text}
    countries
  end

  def self.country_details(country)
    page = self.get_page(country)
    country.description = page.css(".tab p")[0].text
  end

  def self.divelocation_urls(object)
    page = self.get_page(object)
    divelocation_urls = []
    page.css("div.searchResults ul li").map do |urls|
      divelocation_urls << urls.css("span.searchResultContent a").attr("href").value
    end
    object_locations = []
    divelocation_urls.each {|url| object_locations << DiveLocation.find_by_url(url)}
    object_locations
  end

  def self.scrape_dive_location_details(dive_location)
    page = self.get_page(dive_location)
    dive_location.description = page.css(".tab p strong").text
    dive_location.country = page.css("span.val")[0].text
    dive_location.area = page.css("span.val")[1].text
    dive_location.water_temp = page.css("span.val")[2].text.gsub("\u00B0", "")
    dive_location.visibility = page.css("span.val")[3].text
    dive_location.depth_range = page.css("span.val")[4].text if dive_location.depth_range
  end
end
