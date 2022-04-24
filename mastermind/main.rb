# Main menu
require_relative 'display.rb'
require_relative 'code.rb'
require_relative 'game.rb'

include Display

# Create play game function
def play_game
  game = Game.new
  game.play
  repeat_game
end

# Repeat game
def repeat_game
  puts "Would you like to play a new game? ('y' for yes or 'n' for no)"
  repeat_input = gets.chomp.downcase
  if repeat_input == 'y'
    play_game
  elsif repeat_input == 'n'
    puts "Thanks for playing!"
  else
    puts display_error
    repeat_game
  end
end

# Start game
play_game