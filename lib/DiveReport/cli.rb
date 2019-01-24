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

  def print_animal_names
    Animal.print_names
    puts "\nPlease enter the number of the animal you want to see more about."
    input = gets.strip.to_i
    if (1..Animal.all.length).include?(input)
      animal = Animal.all[input - 1]
    end
    print_animal_details(animal)
   end

  def print_animal_details(animal)
    puts "#{Scraper.animal_details(animal)}"
    puts "\nHere are locations where #{animal.name} can be found:\n"
    Scraper.divelocation_urls(animal).each.with_index(1) do |location, i|
      puts "#{i}. #{location}"
    end
    dive_location_input(animal)
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
    puts "Visibility: #{dive_location.visibility}"
    puts "Depth Range: #{dive_location.depth_range}"
  end

  def print_regions
    Region.print_names
    puts "\nPlease enter the number of the region you want to see dive locations for."
    input = gets.strip.to_i
    if (1..Region.all.length).include?(input)
      region = Region.all[input - 1]
    end
    print_region_details(region)
  end

    def print_region_details(region)
      puts "#{Scraper.region_details(region)}"
      Scraper.divelocation_urls(region) do |location, i|
        puts "#{i}. #{location}"
      end
    end

  def print_countries
     Country.print_names
     puts "\nPlease enter the number of the country you want to see dive locations for."
     input = gets.strip.to_i
     if (1..Country.all.length).include?(input)
       country = Country.all[input - 1]
     end
     Scraper.scrape_country_details(country)
  end

  def goodbye
    puts "Thank you for using DiveReport!"
  end

  def invalid
    puts "Sorry - that wasn't a valid entry."
  end
end
