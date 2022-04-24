# This is the main file for game to run
# Combine all the other files
require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'game.rb'
require_relative 'display.rb'

# Create play game function
def play_game
  game = Game.new
  game.play
  repeat_game
end

def repeat_game
  puts "Would you like to play a new game? Press 'y' for yes or 'n' for no."
  repeat_input = gets.chomp.downcase
  if repeat_input == 'y'
    play_game
  else
    puts 'Thanks for playing!'
  end
end

# Start game
play_game