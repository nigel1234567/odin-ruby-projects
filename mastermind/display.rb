module Display
  # Intro
  def display_intro
    "Let's play a game of Mastermind! \n\n"
  end

  # Input length of color combination
  def display_combination_length
    "What length do you want the combination to be? (Min 4, max 8)"
  end

  # Computer created combination
  def display_computer_created(number)
    "I have created a combination of #{number} different colors"
  end

  # Player turn to guess
  def display_player_guess(turns)
    "It's time to guess! You have #{turns} turns left!"
  end
  
  # No correct guesses
  def display_no_guess
    "None of the colors nor positions are correct."
  end

  # Some correct guesses
  def display_some_guess(colored, white)
    "\n#{colored} correct color and correct position. \n#{white} correct color but wrong position."
  end

  # Win
  def display_win
    "You have guessed the correct color combination! You won!"
  end

  # Lose
  def display_lose(code)
    "You did not guess the code in time! You lost! The combination was #{code}."
  end

  # Error
  def display_error
    "\e[31mSorry, I don't understand your input. Please try again.\e[0m\n"
  end

end