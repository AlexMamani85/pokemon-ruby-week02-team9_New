require_relative 'game.rb'
require_relative 'pokemon.rb'
require_relative 'pokedex/pokemons.rb'

class Player
  attr_accessor :name, :pokemon, :pokemon_name, :pokemon_level, :pokemon_slave
  def initialize(name, pokemon, pokemon_name, pokemon_level = 1)

    @name = name

    @pokemon = pokemon
    @pokemon_name = pokemon_name
    @pokemon_level = pokemon_level
    @pokemon_slave = Pokemon.new(pokemon, pokemon_level)
  end

  def select_move
    selected_move = ""
    puts "Great master, select your move:"
    puts
    poke_details = Pokedex::POKEMONS[@pokemon]
    puts "1. #{poke_details[:moves][0]}    2. #{poke_details[:moves][1]}      "
    while selected_move.empty?
      print "> "
      selected_move = gets.chomp
    end
  end
end

# Create a class Bot that inherits from Player and override the select_move method

class Bot < Player
  def initialize
    super("bot", "Charmander", "bot_slave", 5)
  end

  def select_move
    selected_move = nil
    poke_details = Pokedex::POKEMONS[@pokemon]
    # puts "1. #{poke_details[:moves][0]}    2. #{poke_details[:moves][1]}      "
    selected_move = rand(0..1)
    #puts "1. #{poke_details[:moves][selected_move]} "
  end
end


bot = Bot.new()
bot.select_move