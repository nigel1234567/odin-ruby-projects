
def caesar_cipher(string, number)
  # Part 1: Create range of alphabets in array
    alphabets = [*("a".."z"),*("A".."Z")]
    index = [*(1..26),*(101..126)]
    hash = Hash[alphabets.zip index]

  # Part 2: Convert string to array
    # Split current string into an array
    array = string.split("")

  # Part 3: Convert array to number array
    array = array.map { |x| 
    # Check if hash has character
    if hash.include?(x)
      hash[x]
    else
      x
    end
  }

  # Part 4: Shifting of numbers in array
    array = array.map { |x| 
    # Check if x is an integer
    if x.is_a? Integer
      # If shifted number is in between 1-26 or 101-126
      if (x + number).between?(1, 26) || (x + number).between?(101, 126)
        x + number  
      elsif (x + number) <= 0 
        if (x + number).between?(-25, 0) 
          26 + (x + number)
        elsif (x + number).between?(-125, -100)
          126 + (x + number)
        else x
        end
      # Else wrap back
      else (x + number) - 26
      end
    # If x is not an integer, return original value
    else x
    end
    }

  # Part 5: Convert numbers back to characters
    # Call for alphabet for each number
    array = array.map { |x| 
    # Check if hash has character
    if hash.has_value?(x)
      hash.key(x)
    else
      x
    end
  }

  # Part 6: Merge array into string
  array.join('')
end

word = "What a string!"

caesar_cipher(word, 5)