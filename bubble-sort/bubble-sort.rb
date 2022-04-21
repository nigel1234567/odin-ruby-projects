def bubble_sort(array)
  # Iterate bubble sort for length of array
  loops = array.length
  while loops != 0
    i = 0
    # Iterate bubble sort once
    while i < loops
      currentNumber = array[i]
      nextNumber = array[i+1]
      # Check if current number is last
      if i != loops-1
        # Check if left > right, when yes, shift current number to the right
        if currentNumber > nextNumber
          array[i] = nextNumber
          array[i+1] = currentNumber
        end
      end
      i += 1
    end
    loops -= 1
  end
array
end

myArray = [4,3,78,2,0,2]
bubble_sort(myArray)
