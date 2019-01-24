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
    Scraper.scrape_animal_details(animal)
   end

   def print_regions
      Region.print_names
      puts "\nPlease enter the number of the region you want to see dive locations for."
      input = gets.strip.to_i
      if (1..Region.all.length).include?(input)
        region = Region.all[input - 1]
      end
      Scraper.scrape_region_details(region)
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
