require_relative './player.rb'

class Game
  attr_accessor :human_player, :players_left, :enemies_in_sight

  def initialize(user)
    @human_player = HumanPlayer.new(user)
    @enemies_in_sight = []
    @players_left = 10

  end

  def kill_player(player)
    @enemies_in_sight.each do |enemy|
      if enemy.name == player
        @enemies_in_sight.delete(enemy)
      end
    end
  end

  def is_still_ongoing?
    @human_player.life_points > 0 && @enemies != []
  end

  def show_players
    @human_player.show_state
    puts "Il reste #{@enemies_in_sight.count} ennemies en vie."
  end

  def menu
    puts "\nQuelle action veux-tu effectuer ?

    a - chercher une meilleure arme
    s - chercher à se soigner

    Attaquer un joueur en vue :
    "
    i = 0
    @enemies_in_sight.each do |enemy|
      if enemy.life_points > 0
        puts "\s\s\s\s#{i} - #{enemy.show_state}"
        i += 1
      end
    end
    print "> "
  end

  def menu_choice
    player_input = gets.chomp
    if player_input == "a"
      @human_player.search_weapon
    elsif player_input == "s"
      @human_player.search_health_pack
    else
      @human_player.attacks(@enemies_in_sight[player_input.to_i])
      @enemies_in_sight.each {|enemy|
        if enemy.life_points <= 0
          kill_player(enemy.name)
        end
      }
    end
  end

  def enemies_attack
    @enemies_in_sight.each {|enemy|
      if enemy.life_points > 0
        puts "\n!!! #{enemy.name} attaque !!!"
      enemy.attacks(@human_player)
    end
    }
  end

  def new_players_in_sight
    if @players_left == @enemies_in_sight
      puts "Tous les joueurs sont déjà en vue."
    else
      player_generator = rand(1..6)
      if player_generator == 1
        "Tranquille Bill. Pas de nouveaux joueurs en route."
      elsif player_generator.between?(2, 4)
        name_gen = "enemy_" + rand(1..9999).to_s
        @enemies_in_sight << Player.new(name_gen)
        puts "Attention ! #{name_gen} arrive pour la castagne !"
      else
        name_gen_1 = "enemy_" + rand(1..9999).to_s
        name_gen_2 = "enemy_" + rand(1..9999).to_s
        @enemies_in_sight << Player.new(name_gen_1) << Player.new(name_gen_2)
      end
    end
  end

  def end
    if @human_player.life_points <= 0
      puts "\nGame Over. You lose."
    else
      puts "\nLa partie est terminée ! Bravo ! You WIN !"
    end
  end

end