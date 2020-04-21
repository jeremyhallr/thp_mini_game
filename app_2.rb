require 'bundler'
Bundler.require

# require_relative 'lib/game'
require_relative 'lib/player'

puts "-------------------------------------------------
|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------"
puts "\nQuel sera ton honorable nom ?"
print "> "
player_name = gets.chomp
user_player = HumanPlayer.new(player_name)

player_1 = Player.new("Josiane")
player_2 = Player.new("José")

ennemies = [player_1, player_2]
i = 1
puts "------------------------------------------------"

while (player_1.life_points > 0 || player_2.life_points > 0) &&user_player.life_points > 0
  puts "Tour #{i}"
  i += 1
  user_player.show_state

  puts "\nQuelle action veux-tu effectuer ?

  a - chercher une meilleure arme
  s - chercher à se soigner

  Attaquer un joueur en vue :
  0 - #{player_1.show_state}
  1 - #{player_2.show_state}"
  print "> "

  action = gets.chomp.to_s
  case action
  when "a"
    user_player.search_weapon
  when "s"
    user_player.search_health_pack
  when "0"
    user_player.attacks(player_1)
  when "1"
    user_player.attacks(player_2)
  else
    puts "Oups... erreur de manip'. Un tour pour rien..."
  end

  sleep(1)

  ennemies.each {|ennemy|
    if ennemy.life_points > 0
      puts "\n!!! #{ennemy.name} attaque !!!"
      ennemy.attacks(user_player)
    end
    }

  sleep(1)

  puts "------------------------------------------------"
end

if user_player.life_points <= 0
  puts "Game Over. You lose."
else
  puts "La partie est terminée ! Bravo ! You WIN !"
end