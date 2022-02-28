require_relative "player"
require_relative "pokedex/moves"

class Battle
  attr_accessor :player1, :player2, :player1_move, :player2_move, :final_dmg   # (complete parameters)
  
  def initialize(player, bot)
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

  # select players moves
  def start
    # Prepare the Battle (print messages and prepare pokemons)
    preparate_a_battle
    # show_oponents
    # Select Players moves
    # the first pokemon attacks to second pokemon
    until @player1.pokemon_slave.fainted? == true || @player2.pokemon_slave.fainted? == true do
      battle_loop(@player1, @player2)
    end
    if @player1.pokemon_slave.fainted? == true
      puts "#{@player1.pokemon_name} FAINTED!"
      puts "--------------------------------------------------"
      puts "#{@player2.pokemon_name} WINS!"
      @player1.pokemon_slave.stats[:hp] = @player1.pokemon_slave.hp_reset
    end
    if @player2.pokemon_slave.fainted? == true
      puts "#{@player2.pokemon_name} FAINTED!"
      puts "--------------------------------------------------"
      puts "#{@player1.pokemon_name} WINS!"
      puts "#{@player1.pokemon_name} gained #{calculate_experience(@player1, @player2)} experience points"
      @player1.pokemon_slave.stats[:hp] = @player1.pokemon_slave.hp_reset
    end
  end

  def battle_loop(player1, player2)
    show_oponents
    @player1.select_move
    player1_move = @player1.poke_move
    @player2.select_move
    player2_move = @player2.poke_move

    # priority check (moves)
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
        if rand(0..1).zero?
          first_move = @player1
          second_move = @player2
        else
          first_move = @player2
          second_move = @player1
        end
      end
    end

    attack(first_move, second_move)
    attack(second_move, first_move)
  end

  def attack(first_move, second_move)
    # Accuracy check 
    first_move_accuracy = Pokedex::MOVES[first_move.poke_move][:accuracy]
    second_move_accuracy = Pokedex::MOVES[second_move.poke_move][:accuracy]
    if rand(100) <= first_move_accuracy
      # puts "--------------------------------------------------"
      puts "#{first_move.pokemon_name} used #{first_move.poke_move}!"
    else
      puts "missed attack" # Pokemon miss attack due accuracy
    end
    # puts first_move
    poke_sp_moves = Pokedex::SPECIAL_MOVE_TYPE
    str_sp_moves = poke_sp_moves.map { |move| move.to_s }
    move_type = Pokedex::MOVES[first_move.poke_move][:type].to_s
    move_power = Pokedex::MOVES[first_move.poke_move][:power].to_i
    offensive_stat = first_move.pokemon_slave.stats[:attack].to_i
    offensive_stat_sp = first_move.pokemon_slave.stats[:special_attack].to_i
    target_defensive_stat = second_move.pokemon_slave.stats[:defense].to_i
    target_defensive_stat_sp = second_move.pokemon_slave.stats[:special_defense].to_i

    ## select wich kind of move dmg apply
    if str_sp_moves.include?(move_type)
      level_c = ((2 * first_move.pokemon_slave.level) / 5).to_f
      base_dmg = (level_c + 2).floor * offensive_stat_sp * (((move_power.to_f / target_defensive_stat_sp.to_f)) / 50).to_f.floor + 2
    else
      base_dmg = (((2 * first_move.pokemon_slave.level.to_f) / 5).to_f + 2).floor * offensive_stat * ((move_power.to_f / target_defensive_stat.to_f) / 50).to_f + 2
    end
    base_dmg = base_dmg.floor
    ## check if  #critical damage
    @final_dmg = base_dmg
    @final_dmg = base_dmg * 1.5 if rand(0..100) <= (1 / 16.to_f) * 100
    ## check effectiveness
    # if exists special multiplier attack,
    multiplier = return_multiplier(move_type, second_move)
    # prints effective
    puts return_multiplier_message(multiplier)
    # prints damage
    prints_damage(second_move, multiplier)
    # update hp
    update_hp(second_move)
    puts "--------------------------------------------------"
  end
  # return multiplier of attack
  def return_multiplier(move_type, second_move)

    multiplier_array = Pokedex::TYPE_MULTIPLIER
    if second_move.pokemon_slave.type.length == 2
      multiplier = multiplier_array.find { |x| x[:user] == move_type.to_sym && x[:target] == second_move.pokemon_slave.type[0].to_sym }
      if multiplier.nil?
        multiplier = 1
      else
        multiplier = multiplier[:multiplier]
      end

      multiplier2 = multiplier_array.find { |x| x[:user] == move_type.to_sym && x[:target] == second_move.pokemon_slave.type[1].to_sym }
      multiplier += multiplier2[:multiplier] unless multiplier2.nil?
    else
      multiplier = multiplier_array.find { |x| x[:user] == move_type.to_sym && x[:target] == second_move.pokemon_slave.type.join.to_sym }
      multiplier = multiplier[:multiplier] unless multiplier.nil?
    end
    if multiplier.nil?
      1
    else
      multiplier
    end
  end

  def return_multiplier_message(multiplier)
    case multiplier
    when 0
      "It's ¡not effective at all"
    when 0.5
      "It's not very effective"
    when 1
      "It's regular effective"
    when 2
      "It's super effective"
    else
      "It's super very effective"
    end
  end

  def prints_damage(second_move, multiplier)
    @final_dmg *= multiplier
    puts "And it hit #{second_move.pokemon_name} with #{@final_dmg} damage"
  end

  def update_hp(second_move)
    second_move.pokemon_slave.stats[:hp] -= @final_dmg
  end

  def calculate_experience(player_winner, player_loser)
    gain_xp = (player_winner.pokemon_slave.base_exp.to_f * player_loser.pokemon_slave.level.to_f / 7.0).to_f.floor
    player_winner.pokemon_slave.experience_points_gained = gain_xp
    player_winner.pokemon_slave.raise_level
    gain_xp
  end
end
