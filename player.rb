#require_relative 'game.rb'
require_relative 'pokemon.rb'
require_relative 'pokedex/pokemons.rb'

class Player
  attr_accessor :name, :pokemon, :pokemon_name, :pokemon_level, :pokemon_slave, :poke_move
  def initialize(name, pokemon, pokemon_name, pokemon_level = 1)

    @name = name

    @pokemon = pokemon
    p pokemon_name
    @pokemon_name = pokemon_name
    #if pokemon_name == "" || pokemon_name == nil
    #  @pokemon_name = @pokemon
    #end
    @pokemon_level = pokemon_level
    @pokemon_slave = Pokemon.new(pokemon, pokemon_level)
  end

  def select_move
    selected_move = ""
    #puts "Great master, select your move:"
    puts "#{@name}, select your move:"
    puts
    poke_details = Pokedex::POKEMONS[@pokemon]
    puts "1. #{poke_details[:moves][0]}    2. #{poke_details[:moves][1]}      "
    while selected_move.empty?
      print "> "
      selected_move = gets.chomp
    end
    @poke_move = selected_move
  end
end

# Create a class Bot that inherits from Player and override the select_move method

class Bot < Player
  def initialize(name, pokemon, pokemon_name, pokemon_level = 1)
    super(name, pokemon, pokemon_name, pokemon_level)
  end

  def select_move
    poke_details = Pokedex::POKEMONS[@pokemon]
    random_move = rand(0..1)
    bot_move = poke_details[:moves][random_move]
    # puts "#{@pokemon_name} used #{bot_move}"
    @poke_move = bot_move
  end

end