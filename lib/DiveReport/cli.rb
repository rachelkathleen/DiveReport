class CLI
  def welcome
    puts "Welcome to DiveReport! Use this gem to find dive locations that are of interest to you."
    puts "Would you like to find dive locations based on marine life, region or country?"
    puts "Enter 'animals', 'regions' or 'countries'."
    puts "To quit, type 'exit'."
  end

  def first_input
    input = ""

    while input != "exit"
    input = gets.strip

    case input
    when "animals"
        print_animal_names
      when "regions"
        print_regions
      when "countries"
        print_countries
      when "exit"
        goodbye
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
    show_info(animal)
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
