# Create game logic and conditions for display

require_relative 'display.rb'

class Game
  include Display # Include module
  attr_reader :first_player, :second_player, :board, :current_player

  def initialize
    @board = Board.new
    @first_player = nil
    @second_player = nil
    @current_player = nil
  end

  # Run methods to play game
  def play
    game_set_up # Step 1: Setup -> Create players and symbols
    board.show # Step 2: Display board
    player_turns # Step 3: Gameplay -> Run player turns (Loop)
    conclusion # Step 4: Game over
  end

  # Method to create player (ensure that symbol is not duplicated)
  def create_player(number, duplicate_symbol = nil)
    puts display_name_prompt(number)
    name = gets.chomp
    symbol = symbol_input(duplicate_symbol)
    Player.new(name, symbol)
  end

  # Update player chosen cell with symbol in their turn
  def turn(player)
    cell = turn_input(player)
    board.update_board(cell-1, player.symbol)
    board.show
  end

  # Private methods
  private

  # Set up game
  def game_set_up
    puts display_intro
    @first_player = create_player(1)
    # Ensure second player does not duplicate symbol
    @second_player = create_player(2, first_player.symbol)
  end

  # Input symbol (check if player 2 symbol is duplicate of player 1)
  def symbol_input(duplicate)
    player_symbol_prompts(duplicate) # If symbol is duplicated, run error
    input = gets.chomp
    # Register symbol if not duplicate
    return input if input.match?(/^[^0-9]$/) && input != duplicate # Return this if not duplicate and skip later lines

    # If not valid input (0 - 9)
    puts display_input_warning
    symbol_input(duplicate)
  end

  # If duplicate symbol, display error
  def player_symbol_prompts(duplicate)
    puts display_symbol_prompt
    puts display_first_symbol(duplicate) if duplicate
  end
  
  # Player turns
  def player_turns
    @current_player = first_player
    until board.full? # Loop this until board is full
      turn(current_player)
      break if board.game_over? # If game over, break loop

      # If not over, switch players
      @current_player = switch_current_player
    end
  end

  # Turn input
  def turn_input(player)
    puts display_player_turn(player.name, player.symbol)
    number = gets.chomp.to_i
    return number if board.valid_move?(number) # Check if number is a valid move (from board rules)

    # If not valid input, display warning and run method again
    puts display_input_warning
    turn_input(player)
  end

    # Switch player
    def switch_current_player
      if current_player == first_player
        second_player
      else
        first_player
      end
    end

    # End of game
    def conclusion
      if board.game_over?
        puts display_winner(current_player.name)
      else
        puts display_tie
      end
    end
end
