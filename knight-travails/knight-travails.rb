class Board
  attr_accessor :board

  def initialize
    @board = build_board
  end

  def build_board
    # Create rows of cells
    num_array = *(0..7)
    board_array = []
    i = 0
    while i < num_array.length
      j = 0
      row_array = []
      while j < num_array.length
        data = [num_array[i], num_array[j]]
        board_array.push(Cell.new(data))
        j += 1
      end
      i += 1
    end
    board_array
  end

  # Create all possible moves the knight can make as children in tree
  def knight_moves(cell_start, cell_end, moves = 0, path = [])
    cell = nil
    @board.each do |board_cell|
      if board_cell.data == cell_start
        cell = board_cell
      end
    end
    p cell.data
    move_array = create_moves(cell.data)
    # # Base case
    # if cell == cell_end
    #   puts "You made it in #{moves} moves! Here's your path:"
    #   path.each do |move|
    #     puts move
    #   end
    #   return
    # # Move to next cell
    # else
    #   # Create recursion for possible moves (using BFS)
    #   queue = []
    #   move_array.each do |move|
    #     path.push(move)
    #     moves += 1
    #     p path
    #     sleep(1)
    #     knight_moves(move, cell_end, moves, path)
    #   end
    # end
  end

  def create_moves(cell)
    # Create moves
    move_array = []
    move_array.push([cell[0]-2,cell[1]-1])
    move_array.push([cell[0]-2,cell[1]+1])
    move_array.push([cell[0]-1,cell[1]-2])
    move_array.push([cell[0]-1,cell[1]+2])
    move_array.push([cell[0]+1,cell[1]-2])
    move_array.push([cell[0]+1,cell[1]+2])
    move_array.push([cell[0]+2,cell[1]-1])
    move_array.push([cell[0]+2,cell[1]+1])
  
    # Remove negatives and update array
    updated_array = []
    move_array.each do |move|
      if move[0] >= 0 && move[1] >= 0
        updated_array.push(move)
      end
    end
    updated_array
  end
end

class Cell
  attr_reader :data
  attr_accessor :travelled
  def initialize(data)
    @data = data
    @travelled = false
  end

end

x = Board.new
x.knight_moves([3,3],[4,3])