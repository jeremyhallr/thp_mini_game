require_relative './player.rb'

class Game
  attr_accessor :human_player, :enemies

  def initialize(user)
    @human_player = HumanPlayer.new(user)
    @enemies = [Player.new("enemy_1"), Player.new("enemy_2"), Player.new("enemy_3"), Player.new("enemy_4")]
  end

  def kill_player(player)
    @enemies.each do |enemy|
      if enemy.name == player
        @enemies.delete(enemy)
      end
    end
  end

  def is_still_ongoing?
    @human_player.life_points > 0 && @enemies != []
  end

  def show_players
    @human_player.show_state
    puts "Il reste #{@enemies.count} ennemies en vie."
  end

  def menu
    puts "\nQuelle action veux-tu effectuer ?

    a - chercher une meilleure arme
    s - chercher à se soigner

    Attaquer un joueur en vue :
    "
    i = 0
    @enemies.each do |enemy|
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
      @human_player.attacks(@enemies[player_input.to_i])
      @enemies.each {|enemy|
        if enemy.life_points <= 0
          kill_player(enemy.name)
        end
      }
    end
  end

  def enemies_attack
    @enemies.each {|enemy|
      if enemy.life_points > 0
        puts "\n!!! #{enemy.name} attaque !!!"
      enemy.attacks(@human_player)
    end
    }
  end

  def end
    if @human_player.life_points <= 0
      puts "\nGame Over. You lose."
    else
      puts "\nLa partie est terminée ! Bravo ! You WIN !"
    end
  end

end