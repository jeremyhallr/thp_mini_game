class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    if @life_points > 0
      return "#{@name} a #{@life_points} points de vie"
    else
      return "#{@name} est mort"
    end
  end

  def gets_damage(damage_inflicted)
    @life_points = @life_points - damage_inflicted
    if @life_points <= 0
      puts "Le joueur #{name} a été tué !"
    end
  end

  def attacks(player_attacked)
    puts "#{name} attaque #{player_attacked.name}"
    damage_inflicted = compute_damage
    puts "Il lui inflige #{damage_inflicted} points de dommage"
    player_attacked.gets_damage(damage_inflicted)
  end

  def compute_damage
    return rand(1..6)
  end

end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    @name = name
    @weapon_level = 1
    @life_points = 100
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    weapon_level_generator = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{weapon_level_generator}"
    if weapon_level_generator > @weapon_level
      @weapon_level = weapon_level_generator
      puts "Yeeeha ! Bien meilleure que ton arme actuelle, cette nouvelle arme devient tienne."
    else
      puts "Flûte alors... ce bout de bois ne vaut pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    health_pack_generator = rand(1..6)
    puts "health_pack_generator = #{health_pack_generator}"
    if health_pack_generator == 1
      puts "Tu n'as rien trouvé..."
    elsif health_pack_generator.between?(2, 5)
      @life_points += 50
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    else
      @life_points += 80
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end

end