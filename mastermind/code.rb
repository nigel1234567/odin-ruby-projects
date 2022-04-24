require_relative 'display.rb'
# Generate code to be guessed
class Code
  include Display
  attr_reader :code, :length, :colored, :white

  CODE_COLORS = ["r", "b", "g", "y", "o", "p", "w", "d"].freeze

  def initialize
    @code = nil
    @length = nil
    @colored = 0
    @white = 0
  end

  # Guess (string to array)
  def guess(guess)
    # Refresh colored and white
    @colored = 0
    @white = 0
    letter_counts = {}
    # Split string into array
    guess = guess.downcase.split('')
    # Create hash containing duplicates for each letter
    guess.each { |letter| 
      if letter_counts[letter] != nil
        letter_counts[letter] += 1
      else
        letter_counts[letter] = 1
      end
    }

    guess.each_with_index { |letter, index|
    # Check code includes letter
    if @code.include?(letter)
      # Check if guess contains duplicate
      if letter_counts[letter] == 0
        next
      # Check letter position is correct
      elsif @code.index(letter) == index
        @colored += 1
        letter_counts[letter] = 0
      # If letter position not correct and there are still duplicates, move to the next duplicate
      elsif letter_counts[letter] != 1
        letter_counts[letter] -= 1
      # If letter position not correct and no more duplicates
      else
        @white += 1
      end
    end
    }
    # Display feedback
    puts "Colored: #{colored}, White: #{white}"
  end

  # Feedback
  def guess_feedback
    if @colored + @white == 0
      puts display_no_guess
    else
      puts display_some_guess(@colored, @white)
    end
  end

  # Generate code
  def generate_code(length)
    @code = CODE_COLORS.sample(length)
    @length = length
  end

  # Check that guess is valid
  def guess_valid(guess, length)
    guess_length = guess.length.to_i
    guess = guess.downcase.split('')
    # Check that all letters are in CODE_COLORS
    code_check = true
    guess.each { |letter| 
      unless CODE_COLORS.include?(letter) # Excludes?
        code_check = false
      end
    }
    if guess_length != length.to_i || code_check == false
      return false
    else
      return true
    end
  end
end
