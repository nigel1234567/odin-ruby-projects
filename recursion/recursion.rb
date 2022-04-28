def fibs(x)
  sequence = []
  if x < 0
    puts "Number cannot be negative."
  elsif x == 1
    sequence.push(0)
  elsif x == 2
    sequence.push(0)
    sequence.push(1)
  else
    sequence.push(0)
    sequence.push(1)
    i = 2
    until i == x
      number = sequence[i-1] + sequence[i-2]
      sequence.push(number)
      i += 1
    end
  end
  sequence
end

fibs(11)

# Fibonacci sequence using recursion
def fibs_rec(x)
  sequence = []
  if x < 0
    puts "Number cannot be negative."
  elsif x == 1
    sequence.push(0)
  elsif x == 2
    sequence.push(0)
    sequence.push(1)
  else
    sequence = fibs_rec(x-1)
    number = fibs_rec(x-1)[-1] + fibs_rec(x-2)[-1]
    sequence.push(number)
  end
  sequence
end

fibs_rec(11)

# Merge sort
# When array is more than 1, split into 2
# When array is 1 (cannot be split), merge the numbers back in sorted order (do when array has 2 values left)
# Select minimum of the 2 values and add to array
# When one list is empty, copy all values from remaining array into sorted array
def merge_sort(array)
  if array.size < 2
    array
  else
    left = merge_sort(array[0...array.size / 2])
    right = merge_sort(array[array.size / 2...array.size])
    merge(left, right)
  end
end

# Merge once array has 2 halves
def merge(left, right, array = [])
  (left.size + right.size).times do
    
    if left.empty?
      array << right.shift
    elsif right.empty?
      array << left.shift
    else
      comparison = left <=> right
      if comparison == -1
        array << left.shift
      elsif comparison == 1
        array << right.shift
      else
        array << left.shift
      end
    end
  end
  array
end

arr = [9, 2, 5, 6, 1, 3, 7]

p merge_sort(arr)


