require_relative 'cell'
require_relative 'player'

class Board
  
  attr_reader :cells, :player_one, :player_two

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @cells = [] # 6 rows * 7 columns
    create_cells
  end

  # Create cells
  def create_cells
    row = 0
    while row < 6
      col = 0
      row_array = []
      while col < 7
        row_array << Cell.new
        col += 1
      end
      @cells << row_array
      row += 1
    end
  end

  # Display cells
  def display
    puts " 1  2  3  4  5  6  7 "
    @cells.each do |cell|
      puts " #{cell[0].symbol}  #{cell[1].symbol}  #{cell[2].symbol}  #{cell[3].symbol}  #{cell[4].symbol}  #{cell[5].symbol}  #{cell[6].symbol} "
    end
  end

  # Update cell
  def update_board(player, number)
    i = 5
    loop do
      if i < 0
        puts "Current column is full! Please select another column."
        return false
      end
      current_cell = @cells[i][number.to_i]
      if current_cell.symbol == "○"
        current_cell.update(player.name, player.symbol)
        return true
      end
      i -= 1
    end
  end

  #Game over
  def game_over?
    win_checks = [win_horizontal, win_vertical, win_diagonal_r, win_diagonal_l]
    if win_checks.any? { |check| check == true }
      true
    else
      false
    end
  end
  
  # Winning combinations
  def win_horizontal
    for row in @cells
      i = 0
      # Check horizontal
      while i < 3 # Up to middle of board
        combo = [ row[i].player, row[i+1].player, row[i+2].player, row[i+3].player ]
        if combo.uniq.length == 1 && combo[0] != nil
          return true
        end
      i += 1
      end
    end
    false
  end

  def win_vertical
    i = 0
    while i < 3 # Check till middle of board
      j = 0
      while j < 6
        combo = [ @cells[i][j].player, @cells[i+1][j].player, @cells[i+2][j].player, @cells[i+3][j].player ]
        if combo.uniq.length == 1 && combo[0] != nil
          return true
        end
        j += 1
      end
      i += 1
    end
    false
  end

  def win_diagonal_r
    i = 0
    while i < 3 # Check till middle of board
      j = 0
      while j < 2 # Check till middle of board
        combo = [ @cells[i][j].player, @cells[i+1][j+1].player, @cells[i+2][j+2].player, @cells[i+3][j+3].player ]
        if combo.uniq.length == 1 && combo[0] != nil
          return true
        end
        j += 1
      end
      i += 1
    end
    false
  end

  def win_diagonal_l
    i = 0
    while i < 3 # Check till middle of board
      j = 6
      while j > 2 # Check till middle of board
        combo = [ @cells[i][j].player, @cells[i+1][j-1].player, @cells[i+2][j-2].player, @cells[i+3][j-3].player ]
        if combo.uniq.length == 1 && combo[0] != nil
          return true
        end
        j -= 1
      end
      i += 1
    end
    false
  end
end

# x = Board.new
# x.create_cells
# x.display
# play = true
# while play == true
#   puts "Player 1"
#   input = gets.chomp.to_i
#   if input == 0
#     play = false
#     break
#   end
#   input -= 1
#   x.update_board(x.player_one, input)
#   x.display
#   p x.game_over?
#   puts "Player 2"
#   input = gets.chomp.to_i
#   if input == 0
#     play = false
#     break
#   end
#   input -= 1
#   x.update_board(x.player_two, input)
#   x.display
#   p x.game_over?
# end


