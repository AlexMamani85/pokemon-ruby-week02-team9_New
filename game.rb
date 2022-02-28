# require neccesary files
require_relative "player.rb"
require_relative 'pokemon.rb'
require_relative 'battle.rb'
class Game
  attr_accessor :player1, :player2
  def initialize()
  end
  def get_input(promt)
    input = ""
      while input.empty?
        puts promt
        print "> "
        input = gets.chomp
      end
      input 
  end
  def show_stats
    # Complete this
    #12 stats
    pokemon1 = @player1.pokemon_slave
    puts "#{@player1.pokemon_name}:"
    puts "Kind: #{pokemon1.pokemon}"

    puts "Type: #{pokemon1.type[0]} #{pokemon1.type[1]}"
    puts "Level: #{pokemon1.level}"
    puts "Stats:"
    puts "HP: #{pokemon1.stats[:hp]}"
    puts "Defense: #{pokemon1.stats[:defense]}"
    puts "Special Attack: #{pokemon1.stats[:special_attack]}"
    puts "Special Defense: #{pokemon1.stats[:special_defense]}"
    puts "Speed: #{pokemon1.stats[:speed]}"
    puts "Experience Points: #{pokemon1.experience_points}"

  end

  def challenge_leader
    player = Bot.new("Brock", "Onix", "Onix", 10)
    puts "#{@player1.name} challenge the  Gym Leader #{player.name} for a fight!
    #{player.name} has a #{player.pokemon_slave.pokemon} level #{player.pokemon_slave.level}
    What do you want to do now?"
    puts
    puts "1. Fight        2. Leave"
    print "> "
    if gets.chomp.downcase.capitalize == "fight".downcase.capitalize
    battle = Battle.new(@player1, player)
    battle.start
    else
      puts "exit"
    end
  end

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

    
    name = get_input("First, what is your name?")

    puts "Right! So your name is #{name.upcase}!
    Your very own POKEMON legend is about to unfold! A world of
    dreams and adventures with POKEMON awaits! Let's go!
    Here, #{name.upcase}! There are 3 POKEMON here! Haha!
    When I was young, I was a serious POKEMON trainer.
    In my old age, I have only 3 left, but you can have one! Choose!"
    puts
    starter_pokemon = get_input("1. Bulbasaur    2. Charmander   3. Squirtle ")
    puts "You selected  #{starter_pokemon}. Great choice!"
    puts "Give your pokemon a name?"
    print "> "
    starter_name = gets.chomp.downcase.capitalize 
    starter_name = starter_pokemon if starter_name.empty?
    @player1 = Player.new(name, starter_pokemon, starter_name)
    puts "#{name.upcase}, raise your young #{starter_name.upcase} by making it fight!
    When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER"
   

    action = ""
    until action == "Exit"
      puts "-----------------------Menu-----------------------"
      puts
      puts "1. Stats        2. Train        3. Leader       4. Exit"
      menu = gets.chomp.downcase.capitalize
      action = menu
      case action
        
      when "Train"
        train
        action = menu
      when "Leader"
        challenge_leader
        action = menu
      when "Stats"
        show_stats
        # action = menu
      end
    end
    goodbye
  end

  end
  def train
    pokemons_hash = Pokedex::POKEMONS
    all_pokemons = pokemons_hash.collect {| key, value| key }
    random_poke = all_pokemons.sample
    random_level = rand(1..10) ###Pokemon Level random chose
    @player2 = Bot.new("Random Person", random_poke, "", random_level)

    puts "#{@player1.name} challenge Random Person for training"
    puts "Random Person has a #{random_poke} level #{random_level}"
    puts "What do you want to do now?"
    puts
    puts "1. Fight        2. Leave        "
    print "> "
    if gets.chomp.downcase.capitalize == "fight".downcase.capitalize
      train_battle = Battle.new(@player1, @player2)
      train_battle.start
    else
      puts "exit"
    

  end

  

  

  def goodbye
    # Complete this
  end

  def menu
    # Complete this
  end
end
#game.start

game = Game.new()
game.start
#pokemon = Pokemon.new("Charmander", 3)