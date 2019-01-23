class CLI

  def run
    puts "Welcome to DiveReport! Use this gem to find dive locations that are of interest to you."
    Scraper.scrape_directory site
    puts "\n Would you like to find dive locations based on marine life, region or country?"
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
  end

  def print_animal_names
    input = ""
    puts "Please enter the number of the animal you want to see more about."
    Animal.print_names
    input = gets.strip.to_i
    if (1..Animal.all.length).include?(input)
      animal = Animal.all[input - 1]
    end
    Scraper.scrape_animal_details
   end

   def print_regions
      Region.all.each.with_index(1) {|region, i| puts "#{i}. #{region.name}"}
  end

  def print_countries
     Country.all.each.with_index(1) {|country, i| puts "#{i}. #{country.name}"}
  end

  def goodbye
    puts "Thank you for using DiveReport!"
  end
end
