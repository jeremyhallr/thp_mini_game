require 'pry'

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "-------------------------------------------------
|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------"
puts "\nQuel sera ton honorable nom ?"
print "> "
player_name = gets.chomp
my_game = Game.new(player_name)

while my_game.is_still_ongoing?
  puts "-------------------------------------------------"
  my_game.new_players_in_sight
  my_game.show_players
  my_game.menu
  my_game.menu_choice
  my_game.enemies_attack
end

my_game.end

binding.pry