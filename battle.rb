require_relative "player"
require_relative "pokedex/moves"

class Battle
  attr_accessor :player1, :player2, :player1_move, :player2_move    # (complete parameters)
  def initialize (player, bot)
    @player1 = player
    @player2 = bot
  end

  def preparate_a_battle
    puts "#{@player2.name} sent out #{@player2.pokemon.upcase}!"
    puts "#{@player1.name} sent out #{@player1.pokemon_name.upcase}!"
    puts "-------------------Battle Start!-------------------"
  end

  #Show oppents stats
  def show_oponents
    puts "#{@player1.name}'s #{@player1.pokemon_name.capitalize} - Level #{@player1.pokemon_level}"
    puts "HP: #{@player1.pokemon_slave.stats[:hp]}"
    puts "#{@player2.name}'s #{@player2.pokemon.capitalize} - Level #{@player2.pokemon_level}"
    puts "HP: #{@player2.pokemon_slave.stats[:hp]}"
  end

  #select players moves
  
  
  def start(player1, player2)
    # Prepare the Battle (print messages and prepare pokemons)
    preparate_a_battle
    show_oponents

    #Select Players moves

    @player1.select_move
    player1_move = @player1.poke_move
    @player2.select_move
    player2_move = @player2.poke_move


    #priority check (moves)
    first_move = nil
    second_move = nil
    poke1_priority = Pokedex::MOVES[player1_move][:priority]
    poke2_priority = Pokedex::MOVES[player2_move][:priority]
    
    if poke1_priority > poke2_priority
      first_move = @player1
      second_move = @player2
    elsif poke1_priority < poke2_priority
      first_move = @player2
      second_move = @player1
    else
      poke1_speed = @player1.pokemon_slave.stats[:speed]
      poke2_speed = @player2.pokemon_slave.stats[:speed]
      if poke1_speed > poke2_speed 
        first_move = @player1
        second_move = @player2
      elsif poke1_speed < poke2_speed
        first_move = @player2
        second_move = @player1
      else
        if rand(0..1) == 0
          first_move = @player1
          second_move = @player2
        else
          first_move = @player2
          second_move = @player1
        end
      end
    end

    #Accuracy check 
    first_move_accuracy= Pokedex::MOVES[first_move.poke_move][:accuracy]
    second_move_accuracy= Pokedex::MOVES[second_move.poke_move][:accuracy]
    
    if rand(100) <= first_move_accuracy
      puts "--------------------------------------------------"
      puts "#{first_move.pokemon_name} used #{first_move.select_move}!"
      puts "It's not very effective..." 
      ##super effective, not very effective, not effective at all or regular
      puts "And it hit Onix with 1 damage"
    else
      puts "missed attack" #Pokemon miss attack due accuracy
    end

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
    #SPECIAL_MOVE_TYPE = %i[water grass fire ice electric psychic dragon dark]

  end

  def attack(first_move, second_move)
    poke_sp_moves= Pokedex::SPECIAL_MOVE_TYPE
    str_sp_moves = poke_sp_moves.map { |move| move.to_s }
    move_type = Pokedex::MOVES[first_move.poke_move][:type].to_s
    move_power = Pokedex::MOVES[first_move.poke_move][:power].to_i
    offensive_stat = first_move.pokemon_slave.stats[:attack].to_i
    offensive_stat_sp = first_move.pokemon_slave.stats[:special_attack].to_i
    target_defensive_stat = second_move.pokemon_slave.stats[:defense].to_i
    target_defensive_stat_sp = second_move.pokemon_slave.stats[:special_defense].to_i


    ##select wich kind of move dmg apply
    if str_sp_moves.include?(move_type)
      base_dmg = ((2 * first_move.pokemon_slave.level) / (5.0 + 2)).floor * offensive_stat_sp * (((move_power /  target_defensive_stat_sp).floor) / 50.0).floor + 2
    else
      base_dmg = ((2 * first_move.pokemon_slave.level) / (5.0 + 2)).floor * offensive_stat * (((move_power /  target_defensive_stat).floor) / 50.0).floor + 2
    end

    ##check if  #critical damage
    if rand(0..100) <= (1/16.to_f)*100
      final_dmg = base_dmg * 1.5
    end
    p "#{final_dmg} XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    ##check effectiveness
    ## TYPE_MULTIPLIER = [
    # { user: :normal, target: :rock, multiplier: 0.5 }],
    multiplier_array = Pokedex::TYPE_MULTIPLIER
    p multiplier_array.find { |x| x[:user] == move_type.to_sym && x[:target] == second_move.pokemon_slave.type}
  end
end

player1 = Player.new("eeeee", "Pikachu", "aaa", 10)
player2 = Bot.new("Leader", "Ratata", "ratita", 5)
battle = Battle.new(player1, player2)
battle.start(player1, player2)
battle.attack(player1, player2)