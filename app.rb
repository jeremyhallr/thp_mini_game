require 'bundler'
Bundler.require

# require_relative 'lib/game'
require_relative 'lib/player'

player_1 = Player.new("Josiane")
player_2 = Player.new("José")

puts "A ma droite #{player_1.name}
#{player_1.show_state}"

puts "\nA ma gauche #{player_2.name}
#{player_2.show_state}"

puts "\nPassons au fight !"
puts "Parés au combat ?"
puts "3"
sleep(0.5)
puts "2"
sleep(0.5)
puts "1"
sleep(0.5)
puts "LET'S FIGHT !"
puts ""

while player_1.life_points > 0 && player_2.life_points > 0
  player_1.attacks(player_2)
  if player_2.life_points <= 0
    break
  end
  player_2.attacks(player_1)
  if player_1.life_points <= 0
    break
  end
  puts "\nEtat des joueurs :
#{player_1.show_state}
#{player_2.show_state}"
  puts "---------------------"
end