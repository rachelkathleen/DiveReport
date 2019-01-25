require 'pry'

class CLI

  def run
    puts "Welcome to DiveReport! Use this gem to find dive locations that are of interest to you."
    Scraper.scrape_directory_site
    puts "\nWould you like to find dive locations based on marine life, region or country?"
    puts "\nEnter 'animals', 'regions' or 'countries'."
    puts "\nTo quit, type 'exit'."
    first_input
  end

  def first_input
    input = gets.strip

    if  input == "animals"
        print_animal_names
    elsif input == "regions"
        print_regions
    elsif input == "countries"
        print_countries
    elsif input == "exit"
        goodbye
    else
      invalid
      first_input
    end
  end

  def dive_location_input(object)
    puts "\nSelect a dive location to see more details"
    input = gets.strip.to_i
    dive_locations = Scraper.divelocation_urls(object)
    if (1..dive_locations.length).include?(input)
      dive_location_name = dive_locations[input - 1]
      dive_location_object = DiveLocation.find_by_name(dive_location_name)
    else
      invalid
    end
    print_location_details(dive_location_object)
  end

  def print_location_details(dive_location)
    Scraper.scrape_dive_location_details(dive_location)
    puts "#{dive_location.description}"
    puts "\nWater Temperature: #{dive_location.water_temp}"
    puts "Visibility: #{dive_location.visibility}"
    puts "Depth Range: #{dive_location.depth_range}" if dive_location.depth_range
    goodbye_or_menu
  end

  def print_animal_names
    Animal.print_names
    puts "\nPlease enter the number of the animal you want to see more about."
    input = gets.strip.to_i
    if (1..Animal.all.length).include?(input)
      animal = Animal.all[input - 1]
      print_animal_details(animal)
    else
      invalid
      print_animal_names
    end
   end

  def print_animal_details(animal)
    puts "#{Scraper.animal_details(animal)}"
    puts "\nHere are locations where #{animal.name} can be found:\n"
    Scraper.divelocation_urls(animal).each.with_index(1) do |location, i|
      puts "#{i}. #{location}"
    end
    dive_location_input(animal)
  end

  def print_regions
    Region.print_names
    puts "\nPlease enter the number of the region you want to see dive locations for."
    input = gets.strip.to_i
    if (1..Region.all.length).include?(input)
      region = Region.all[input - 1]
      print_region_details(region)
    else
      invalid
      print_regions
    end
  end

  def print_region_details(region)
    Scraper.region_details(region).each.with_index(1) do |country, i|
      puts "#{country}"
    end
    puts "\nHere are dive locations in #{region.name}\n"
    Scraper.divelocation_urls(region).each.with_index(1) do |location, i|
      puts "#{i}. #{location}"
    end
    dive_location_input(region)
  end

  def print_countries
     Country.print_names
     puts "\nPlease enter the number of the country you want to see dive locations for."
     input = gets.strip.to_i
     if (1..Country.all.length).include?(input)
       country = Country.all[input - 1]
       print_country_details(country)
     else
       invalid
       print_countries
     end 
  end

  def print_country_details(country)
    puts "#{Scraper.country_details(country)}" if country.description
    puts "\nHere are dive locations in #{country.name}\n"
    Scraper.divelocation_urls(country).each.with_index(1) do |location, i|
      puts "#{i}. #{location}"
    end
    dive_location_input(country)
  end

  def dive_location_input(object)
    puts "\nSelect a dive location to see more details"
    input = gets.strip.to_i
    dive_locations = Scraper.divelocation_urls(object)
    if (1..dive_locations.length).include?(input)
      dive_location_name = dive_locations[input - 1]
      dive_location_object = DiveLocation.find_by_name(dive_location_name)
    else
      invalid
      input = gets.strip.to_i
    end
    print_location_details(dive_location_object)
  end

  def goodbye
    puts "\nThank you for using DiveReport!"
  end

  def invalid
    puts "Sorry - that wasn't a valid entry - please try again."
  end

  def goodbye_or_menu
    puts "\nWould you like to seach for another dive location?"
    puts "\nEnter 'animals', 'regions' or 'countries'."
    puts "\nTo quit, type 'exit'."
    first_input
  end
end
