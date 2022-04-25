module Messages

  def message_intro
    "Welcome to the game of Hangman!\n\n"
  end

  def message_create_word(secret_word)
    "A #{secret_word.to_s.length}-letter word has been created."
  end

  def message_attempts_left(attempts)
    "You have #{attempts} attempts left."
  end

  def message_guessed_word(guessed_word)
    "Word: #{guessed_word}"
  end

  def message_guessed_letters(guessed_letters)
    "Letters already guessed: #{guessed_letters}."
  end

  def message_player_guess
    "It's time for you to guess the word! Please enter a letter (A-Z):"
  end

  def message_player_lose(secret_word)
    "You have no attempts left! The word was '#{secret_word}'\n"
  end

  def message_player_win(secret_word)
    "You have guessed the word! The word is '#{secret_word}'\n"
  end

  def message_error
    "\e[31mSorry, I don't understand your input. Please try again.\e[0m\n"
  end

  def message_no_guess(letter)
    "There is no '#{letter}' in the word.\n\n"
  end

  def message_correct_guess(letter)
    "There are '#{letter}'s in the word!\n\n"
  end

  def message_save_game?
    "Would you like to save your game? (Y/N)"
  end
end

