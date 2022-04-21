def stock_picker(array)
  # Declare current and next price
  currentPrice = 0
  nextPrice = 0

  # Day
  day = 0
  # Declare max difference
  maxDiff = 0
  while day < array.length do
    # Find current day position and price
    currentPrice = array[day]
    # p "* Current day is: #{day}"

    # Splice array
    nextArray = array[day..array.length]
    # Find nextDay position
    nextDay = day + 1
    # p "* Day is: #{day}, price is: #{currentPrice}"
    # Create second loop to compare next position and price
    while nextDay < array.length do
      # Check if day is last day in array
      if nextDay != array.length
        nextPrice = array[nextDay]
        # Price difference between next day and current day
        diffPrice = nextPrice - currentPrice
        # p "** Comparison day is: #{nextDay}, price is: #{nextPrice}, difference is: #{diffPrice}"
        # Compare difference in price and max difference so far
        if diffPrice > maxDiff
          maxDiff = diffPrice
          maxArray = [day, nextDay]
          # p "Max difference is: #{maxDiff}, the days to buy and sell are: #{maxArray}"
        end
      end
      # Go to next day
      nextDay += 1
    end
    # Go to next day
    day += 1
  end
maxArray
end

myArray = [17,3,6,9,15,8,6,1,10]
stock_picker(myArray)