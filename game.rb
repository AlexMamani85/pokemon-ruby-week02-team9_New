# require neccesary files

class Game
  def start
    # Create a welcome method(s) to get the name, pokemon and pokemon_name from the user

    # Then create a Player with that information and store it in @player

    # Suggested game flow

    puts "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#
#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#
#$##$##$##$ ---        Pokemon Ruby         --- #$##$##$#$#
#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#
#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#"

puts "Hello there! Welcome to the world of POKEMON! My name is OAK!
People call me the POKEMON PROF!"

puts "This world is inhabited by creatures called POKEMON! For some
people, POKEMON are pets. Others use them for fights. Myself...
I study POKEMON as a profession."

def get_input(promt)
  input = ""
    while input.empty?
      puts promt
      print "> "
      input = gets.chomp
    end
    input 
end


name = get_input("First, what is your name?")

puts "Right! So your name is GREAT MASTER!
Your very own POKEMON legend is about to unfold! A world of
dreams and adventures with POKEMON awaits! Let's go!
Here, GREAT MASTER! There are 3 POKEMON here! Haha!
When I was young, I was a serious POKEMON trainer.
In my old age, I have only 3 left, but you can have one! Choose!"
puts
starter_pokemon = get_input("1. Bulbasaur    2. Charmander   3. Squirtle ")
puts "You selected  #{starter_pokemon}. Great choice!"
puts "Give your pokemon a name?"
print "> "
starter_name = gets.chomp.downcase.capitalize 
starter_name = starter_pokemon if starter_name.empty?

puts "#{name.upcase}, raise your young #{starter_name.upcase} by making it fight!
When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER"
puts "-----------------------Menu-----------------------"
puts
puts "1. Stats        2. Train        3. Leader       4. Exit"


    action = menu
    until action == "Exit"
      case action
      when "Train"
        train
        action = menu
      when "Leader"
        challenge_leader
        action = menu
      when "Stats"
        show_stats
        action = menu
      end
    end

    goodbye
  end

  def train
    # Complete this
  end

  def challenge_leader
    # Complete this
  end

  def show_stats
    # Complete this
  end

  def goodbye
    # Complete this
  end

  def menu
    # Complete this
  end
end

game = Game.new
game.start
