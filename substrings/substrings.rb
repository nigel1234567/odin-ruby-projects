dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(string, dictionary)
  # Remove special characters
  string = string.gsub(/[^A-Za-z0-9]/, " ")
  # Convert string to array
  array = string.split(" ")
  array = array.map { |word| word.downcase }

  results = []

#  Compare each word in dictionary into string
  array.each { |arrayWord| 
    dictionary.map { |dictWord| 
      if arrayWord.include?(dictWord) == true
        results.push(dictWord)
      end
    }
  }

  # Reduce into results into new hash
  results.reduce(Hash.new(0)) do |result, word|
    result[word] += 1
    result
  end

end

substrings("Howdy partner, sit down! How's it going?", dictionary)