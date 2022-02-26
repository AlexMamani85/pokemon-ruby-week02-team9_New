require_relative 'pokedex/pokemons.rb'

class Pokemon
  # include neccesary modules
  attr_accessor :poke_details, :species, :type, :base_exp, :growth_rate, :base_stats, :effort_points, :moves, :name, :level, :individual_stats, :effort_values, :experience_points, :stats, :pokemon

  # (complete parameters)
  def initialize (pokemon, level = 1)
    poke_details = Pokedex::POKEMONS[pokemon]
    @pokemon = pokemon
    @species = poke_details[:species]
    @type = poke_details[:type] 
    @base_exp = poke_details[:base_exp]
    @growth_rate = poke_details[:growth_rate]
    @base_stats = poke_details[:base_stats]
    @effort_points = poke_details[:effort_points]
    @moves = poke_details[:moves]
    @stat_effor_base = 0

    # @name = starter_name
    @level = level
    @individual_stats = create_individual_stats
    @effort_values = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 }
    @experience_points = calculate_exp
    @stats = real_stats

    # Retrieve pokemon info from Pokedex and set instance variables
    # Calculate Individual Values and store them in instance variable
    # Create instance variable with effort values. All set to 0
    # Store the level in instance variable
    # If level is 1, set experience points to 0 in instance variable.
    # If level is not 1, calculate the minimum experience point for that level and store it in instance variable.
    # Calculate pokemon stats and store them in instance variable
  end

  def create_individual_stats
     { hp: rand(0..31),
      attack: rand(0..31),
      defense: rand(0..31),
      special_attack: rand(0..31),
      special_defense: rand(0..31),
      speed: rand(0..31) }
  end

  def real_stats
    poke_details = Pokedex::POKEMONS[@pokemon]
    hp = ((((2 * poke_details[:base_stats][:hp] + @individual_stats[:hp] + @stat_effor_base) * @level) / 100) + @level + 10).floor
    attack = ((((2 * poke_details[:base_stats][:attack] + @individual_stats[:attack] + @stat_effor_base) * @level) / 100) + 5).floor
    defense = ((((2 * poke_details[:base_stats][:defense] + @individual_stats[:defense] + @stat_effor_base) * @level) / 100) + 5).floor
    special_attack = ((((2 * poke_details[:base_stats][:special_attack] + @individual_stats[:special_attack] + @stat_effor_base) * @level) / 100) + 5).floor
    special_defense = ((((2 * poke_details[:base_stats][:special_defense] + @individual_stats[:special_defense] + @stat_effor_base) * @level) / 100) + 5).floor
    speed = ((((2 * poke_details[:base_stats][:speed] + @individual_stats[:speed] + @stat_effor_base) * @level) / 100) + 5).floor
    {hp: hp, attack: attack, defense: defense, special_attack: special_attack, special_defense: special_defense, speed: speed}
  end

  def calculate_exp
    calc_exp = 0
    if @level == 1
      calc_exp = 0
    elsif @level > 1
      if growth_rate == :slow
        calc_exp = (5*(@level**3))/4
      elsif growth_rate == :medium_slow
        calc_exp = ((6)*(@level**3)) / 5 - (15 * (@level**2)) + (100 * @level) - (140)
      elsif growth_rate == :medium_fast
        calc_exp = @level ** 3
      elsif growth_rate == :fast
        calc_exp = (4 * (@level) ** 3) / 5
      end
    end
    return calc_exp
  end



  def prepare_for_battle
    # Complete this
  end

  def receive_damage
    # Complete this
  end

  def set_current_move
    # Complete this
  end

  def fainted?
    # Complete this
  end

  def attack(target)
    # Print attack message 'Tortuguita used MOVE!'
    # Accuracy check
    # If the movement is not missed
    # -- Calculate base damage
    # -- Critical Hit check
    # -- If critical, multiply base damage and print message 'It was CRITICAL hit!'
    # -- Effectiveness check
    # -- Mutltiply damage by effectiveness multiplier and round down. Print message if neccesary
    # ---- "It's not very effective..." when effectivenes is less than or equal to 0.5
    # ---- "It's super effective!" when effectivenes is greater than or equal to 1.5
    # ---- "It doesn't affect [target name]!" when effectivenes is 0
    # -- Inflict damage to target and print message "And it hit [target name] with [damage] damage""
    # Else, print "But it MISSED!"
  end

  def increase_stats(target)
    # Increase stats base on the defeated pokemon and print message "#[pokemon name] gained [amount] experience points"

    # If the new experience point are enough to level up, do it and print
    # message "#[pokemon name] reached level [level]!" # -- Re-calculate the stat
  end

  # private methods:
  # Create here auxiliary methods
end