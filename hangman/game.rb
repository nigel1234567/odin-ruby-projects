require 'csv'
require_relative 'messages.rb'

class Game
  include Messages
  attr_reader :secret_word, :guessed_word, :guessed_letters, :secret_word_array, :word_array, :win, :attempts
  attr_accessor :save_array

  def initialize
    @save_array = []
    @secret_word = nil
    @guessed_word = nil
    @guessed_letters = []
    @secret_word_array = []
    @word_array = nil
    @win = false
    @attempts = 10
    puts message_intro
  end

  def play
    if @secret_word == nil
      generate_word
    end
    player_turn
    game_end
  end

  def generate_word
    dictionary_original = CSV.open('dictionary.csv', headers: false)
    dictionary = []

    # Filter words and push into dictionary array
    dictionary_original.each do |word|
      if word[0].length >= 5 && word[0].length <= 12 # Filter only words with length more than 4 and less than 13
        dictionary.push(word[0])
      end
    end
    
    # Randomly pick a word
    @secret_word = dictionary.sample(1)[0]
    @secret_word_array = @secret_word.split("")
    puts message_create_word(@secret_word)

    # Initial create word display
    word_array = Array.new(@secret_word.length, "_")
    @word_array = word_array
    guessed_word = word_array.join(" ")
    @guessed_word = guessed_word
  end

  def player_turn
    win = false
    guess = ""
    until @attempts == 0 || @win == true
      puts message_attempts_left(@attempts)
      puts message_guessed_word(@guessed_word)
      puts message_guessed_letters(@guessed_letters)
      # Option to save game
      save_game
      # Guess
      puts message_player_guess
      guess = gets.chomp
      # Check if guess valid
      if guess_valid?(guess)
        guess(guess)
        if @word_array.include?("_")
          @win = false
        else
          @win = true
        end
      else
        puts message_error
      end
    end
  end

  def save_game
    puts message_save_game?
    save = gets.chomp.downcase
    if save == 'y'
      @save_array = [[@secret_word],
        [@guessed_word],
        @guessed_letters,
        @secret_word_array,
        @word_array, # Arrays don't need to be converted to array
        [@win],
        [@attempts]]
      CSV.open("savedgame.csv", "w") do |csv|
        @save_array.each {|row| csv << row}
      end

        puts "Your game has been saved.\n\n"
    elsif save == 'n'
      puts "Your game has not been saved.\n\n"
    else
      puts message_error
      save_game
    end
  end

  def load_game
    load_data = File.readlines('savedgame.csv')
    @secret_word = load_data[0].chomp
    @guessed_word = load_data[1].chomp
    @guessed_letters = load_data[2].chomp.split(',')
    @secret_word_array = load_data[3].chomp.split(',')
    @word_array = load_data[4].chomp.split(',')
    @win = load_data[5].chomp
    @attempts = load_data[6].chomp.to_i
  end

  # Game end
  def game_end
    if @win == false
      puts message_player_lose(@secret_word)
    else
      puts message_player_win(@secret_word)
    end
  end

  # Valid guess
  def guess_valid?(guess)
    if guess.match?(/^[A-Za-z]/) # Check if alphabet
      if guess.length != 1 || @guessed_letters.include?(guess.downcase)
        false
      else
        true
      end
    else
      false
    end
  end

  # Player guess
  def guess(guess)
    guess = guess.downcase
    @guessed_letters.push(guess) # Don't need check if duplicate again. Covered in guess_valid?
    if @secret_word.include?(guess)
      # Find duplicated letter in word
      duplicates_array = []
      @secret_word_array.each_with_index {|letter, index|
      if letter == guess
        duplicates_array.push(index)
      end
      }
      # Change word_array based on letter guessed
      duplicates_array.each {|pos| @word_array[pos] = guess.upcase}
      @guessed_word = @word_array.join(" ")
      puts message_correct_guess(guess)
    else # Wrong guess
      puts message_no_guess(guess)
      @attempts -= 1
    end
  end
end
