require_relative 'display.rb'
require_relative 'code.rb'

class Game
  include Display
  attr_reader :guess, :code, :turns, :length, :win

  def initialize
    @guess = nil
    @code = nil
    @turns = 12
    @length = 0
    @win = false
    puts display_intro
  end

  def play
    game_start
    player_turn
    game_end
  end

  # Start of game
  def game_start
    puts display_combination_length
    length = gets.chomp.to_i
    if length =~ /[^0-9]/ || length < 4 || length > 8
      puts display_error
      game_start
    else
      @length = length
      @code = Code.new
      @code.generate_code(length)
      puts display_computer_created(length)
    end
  end

  # Player turn
  def player_turn
    until @turns == 0 || @win == true
      puts display_player_guess(@turns)
      guess = gets.chomp
      # Check if guess valid
      if @code.guess_valid(guess, @length)
        @code.guess(guess)
        if @code.colored == @length
          @win = true
        end
        @code.guess_feedback
        @turns -= 1
      else
        puts display_error
      end
    end
  end

  # Game end
  def game_end
    if @win == true
      puts display_win
    else
      correct = @code.code.join('')
      puts display_lose(correct.upcase)
    end
  end

end