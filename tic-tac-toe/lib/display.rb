# Create module for displaying messages
module Display
  # Intro
  def display_intro
    "Let's play a simple game of Tic-Tac-Toe! \n\n"
  end

  # Prompt name of player
  def display_name_prompt(number)
    "What is the name of player ##{number}?"
  end

  # Prompt symbol of player
  def display_symbol_prompt
    "What is 1 letter (or special character) would you like to be your game marker?"
  end

  # Check for duplicate
  def display_first_symbol(duplicate)
    "It cannot be '#{duplicate}'"
  end

  # Warning
  def display_input_warning
    "\e[31mSorry, that is an invalid answer. Please try again. \e[0m"
  end

  # Player turn
  def display_player_turn(name, symbol)
    "#{name}, please enter a number (1-9) that is available to place an '#{symbol}'"
  end

  # Winner
  def display_winner(player)
    "GAME OVER! #{player} is the winner!"
  end

  # Tie
  def display_tie
    "It's a draw!"
  end

end
