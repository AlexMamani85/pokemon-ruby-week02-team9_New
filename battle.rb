require_relative "player"

class Battle
  attr_accessor :player1, :player2  # (complete parameters)
  def initialize (player, bot)
    @player1 = player
    @player2 = bot
  end

  def preparate_a_battle
    puts "#{@player2.name} sent out #{@player2.pokemon.upcase}!"
    puts "#{@player1.name} sent out #{@player1.pokemon_name.upcase}!"
    puts "-------------------Battle Start!-------------------"
  end

  def show_oponents
    puts "#{@player1.name}'s #{@player1.pokemon_name.capitalize} - Level #{@player1.pokemon_level}"
    puts "HP: #{@player1.pokemon_slave.stats[:hp]}"
    puts "#{@player2.name}'s #{@player2.pokemon_name.capitalize} - Level #{@player2.pokemon_level}"
    puts "HP: #{@player2.pokemon_slave.stats[:hp]}"

  end
  def start
    # Prepare the Battle (print messages and prepare pokemons)
    preparate_a_battle
    show_oponents
    # Until one pokemon faints
    # --Print Battle Status
    # --Both players select their moves

    # --Calculate which go first and which second

    # --First attack second
    # --If second is fainted, print fainted message
    # --If second not fainted, second attack first
    # --If first is fainted, print fainted message

    # Check which player won and print messages
    # If the winner is the Player increase pokemon stats

  end
end

player1 = Player.new("eeeee", "Charmander", "aaa", 3)
player2 = Bot.new
battle = Battle.new(player1, player2)
battle.start
