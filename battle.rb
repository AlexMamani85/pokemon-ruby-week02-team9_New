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
    puts "Great master's Great Char - Level 1"
    puts "HP: 12"
q
  end
  def start
    # Prepare the Battle (print messages and prepare pokemons)
    preparate_a_battle
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

player1 = Player.new("eeeee", "Charmander", "aaa")
player2 = Bot.new
battle = Battle.new(player1, player2)
battle.preparate_a_battle