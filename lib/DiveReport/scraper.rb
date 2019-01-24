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


  def divelocation_urls(object)
    html = open("http://www.divereport.com/" + object.url)
    doc = Nokogiri::HTML(html)

    divelocation_urls = []
    doc.css("div.searchResults ul li").map do |urls|
      divelocation_urls << urls.css("span.searchResultContent a").attr("href").value
    end
    object_locations = []
    divelocation_urls.each {|url| object_locations << DiveLocation.find_by_url(url)}
    object_locations.each.with_index(1) do |location, i|
      puts "#{i}. #{location}"
    end
  end

  def self.scrape_animal_details(animal)
    html = open(DIVE_REPORT_URL + animal.url)
    doc = Nokogiri::HTML(html)

    animal.description = doc.css(".animale p")[0].text
    puts "\n#{animal.description}"
    puts "\nHere are dive locations where #{animal.name} can be found"
    #divelocation_urls(animal)
    divelocation_urls = []
    doc.css("div.searchResults ul li").map do |urls|
      divelocation_urls << urls.css("span.searchResultContent a").attr("href").value
    end
    object_locations = []
    divelocation_urls.each {|url| object_locations << DiveLocation.find_by_url(url)}
    object_locations.each.with_index(1) do |location, i|
      puts "#{i}. #{location}"
    end
  end

  def self.scrape_region_details(region)
    html = open(DIVE_REPORT_URL + region.url)
    doc = Nokogiri::HTML(html)

    countries = []
    doc.css(".MainAndOffside div.TabCol h1").each do |country|
      countries << country.text
    end
    puts "Here are countries with dive locations in #{region.name}\n"
    countries.each {|country| puts "#{country}"}
    puts "\nHere are dive locations in #{region.name}"
    #divelocation_urls(region)
    divelocation_urls = []
    doc.css("div.searchResults ul li").map do |urls|
      divelocation_urls << urls.css("span.searchResultContent a").attr("href").value
    end
    object_locations = []
    divelocation_urls.each {|url| object_locations << DiveLocation.find_by_url(url)}
    object_locations.each.with_index(1) do |location, i|
      puts "#{i}. #{location}"
    end
  end

  def self.scrape_country_details(country)
    html = open(DIVE_REPORT_URL + country.url)
    doc = Nokogiri::HTML(html)

    country.description = doc.css(".tab p")[0].text
    puts "\n#{country.description}\n"
    puts "\nHere are dive locations in #{country.name}\n"
    #divelocation_urls(country)
    divelocation_urls = []
    doc.css("div.searchResults ul li").map do |urls|
      divelocation_urls << urls.css("span.searchResultContent a").attr("href").value
    end
    object_locations = []
    divelocation_urls.each {|url| object_locations << DiveLocation.find_by_url(url)}
    object_locations.each.with_index(1) do |location, i|
      puts "#{i}. #{location}"
    end
  end

end
