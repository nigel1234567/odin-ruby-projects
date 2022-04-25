# Main menu
require_relative 'messages.rb'
require_relative 'game.rb'

include Messages

game = nil
# Create play game function
def play_game
  if File.exist?('savedgame.csv')
    puts "You have a saved game! Would you like to continue with your last session? (Y/N)"
    input = gets.chomp.downcase
    if input == "y"
      game = Game.new
      game.load_game
      game.play
      repeat_game
    elsif input == "n"
      game = Game.new
      game.play
      repeat_game
    else
      puts message_error
      play_game
    end
  else
  game = Game.new
  game.play
  repeat_game
  end
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
    puts message_error
    repeat_game
  end
end

# Start game
play_game