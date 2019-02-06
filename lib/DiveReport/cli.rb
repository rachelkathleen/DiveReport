require 'pry'

class CLI

  def run
    puts "Welcome to DiveReport! Use this gem to find dive locations that are of interest to you."
    Scraper.scrape_directory_site
    first_input
  end

  def first_input
    puts "\nWould you like to find dive locations based on marine life, region or country?"
    puts "\nEnter 'animals', 'regions' or 'countries'."
    puts "\nTo quit, type 'exit'."
    input
  end

  def goodbye
    puts "\nThank you for using DiveReport!"
  end

  def goodbye_or_menu
    puts "\nWould you like to seach for another dive location?"
    puts "\nEnter 'animals', 'regions' or 'countries'."
    puts "\nTo quit, type 'exit'."
    input
  end

  def invalid
    puts "Sorry - that wasn't a valid entry - please try again."
  end

  def input
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

  def dive_location_input
    puts "\nSelect a dive location to see more details"
    puts "\nTo go back to the main menu, enter 'menu'"
    input = gets.strip
    if (1..@object.locations.length).include?(input.to_i)
      @dive_location = @object.locations[input.to_i-1]
    elsif input == "menu"
      first_input
    else
      invalid
      dive_location_input
    end
    print_location_details
  end

  def print_location_details
    DiveLocation.add_location_attributes(@dive_location)
    puts "\nHere are details about #{@dive_location.name}:"
    puts "\n#{@dive_location.description}"
    puts "\nCountry: #{@dive_location.country}"
    puts "Area: #{@dive_location.area}"
    puts "Water Temperature: #{@dive_location.water_temp}"
    puts "Visibility: #{@dive_location.visibility}"
    goodbye_or_menu
  end

  def print_animal_names
    Animal.print_names
    puts "\nPlease enter the number of the animal you want to see more about."
    input = gets.strip.to_i
    if (1..Animal.all.length).include?(input)
      @object = Animal.all[input - 1]
      print_object_details
    else
      invalid
      print_animal_names
    end
  end

  def print_countries
    Country.print_names
    puts "\nPlease enter the number of the country you want to see dive locations for."
    input = gets.strip.to_i
    if (1..Country.all.length).include?(input)
     @object = Country.all[input - 1]
    print_object_details
   else
     invalid
     print_countries
    end
  end

  def print_object_details
    puts "#{@object.class.description(@object)}"
    puts "\nHere are dive locations in #{@object.name}\n"
    @object.class.locations(@object).each.with_index(1) do |location, i|
      puts "#{i}. #{location.name}"
    end
    dive_location_input
  end

  def print_regions
    Region.print_names
    puts "\nPlease enter the number of the region you want to see dive locations for."
    input = gets.strip.to_i
    if (1..Region.all.length).include?(input)
      @region = Region.all[input - 1]
      print_region_details
    else
      invalid
      print_regions
    end
  end

  def print_region_details
    @countries = print_countries_in_region
    puts "\nPlease select a country to see dive locations"
    puts "\nOr, enter 'back' to return to the list of regions"
      input = gets.strip
      if input == "back"
        print_regions
      elsif number = input.to_i
        (1..@countries.length).include?(number) && Country.find_by_name(@countries[number -1]) != nil
        @object = Country.find_by_name(@countries[number -1])
        print_object_details
      else
        invalid
        print_region_details
      end
    end
  end

  def print_countries_in_region
    puts "\nHere are countries in #{@region.name}:\n"
    Region.countries(@region).each.with_index(1) do |country, i|
      puts "#{i}: #{country}"
  end
end
