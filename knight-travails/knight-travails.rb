# class Board
#   attr_accessor :board

#   def initialize
#     @board = build_board
#   end

#   def build_board
#     # Create rows of cells
#     num_array = *(0..7)
#     board_array = []
#     i = 0
#     while i < num_array.length
#       j = 0
#       row_array = []
#       while j < num_array.length
#         data = [num_array[i], num_array[j]]
#         board_array.push(Cell.new(data))
#         j += 1
#       end
#       i += 1
#     end
#     board_array
#   end

#   # Create all possible moves the knight can make as children in tree
#   def knight_moves(cell_start, cell_end, path = [cell_start])
#     cell = cell_start
#     move_array = create_moves(cell_start)
    
#     # Base case
#     if cell == cell_end
#       puts "You made it in #{path.length-1} moves! Here's your path:"
#       path.each do |move|
#         p move
#       end

#     # Move to next cell
#     else
#       # Create recursion of possible moves
#       i = 0
#       while i != move_array.length
#         move = move_array[i]
#         unless move == nil || path.include?(move) || path.include?(cell_end)
#           path.push(move)
#           p path
#           sleep(0.1)
#           knight_moves(move, cell_end, path)
#         end
#         i += 1
#       end
#     end
#   end

#   def create_moves(cell)
#     # Create moves
#     move_array = []
#     move_array.push([cell[0]-2,cell[1]-1])
#     move_array.push([cell[0]-2,cell[1]+1])
#     move_array.push([cell[0]-1,cell[1]-2])
#     move_array.push([cell[0]-1,cell[1]+2])
#     move_array.push([cell[0]+1,cell[1]-2])
#     move_array.push([cell[0]+1,cell[1]+2])
#     move_array.push([cell[0]+2,cell[1]-1])
#     move_array.push([cell[0]+2,cell[1]+1])
  
#     # Remove negatives and update array
#     updated_array = []
#     move_array.each do |move|
#       # Ensure that moves are not beyond board size
#       if move[0] >= 0 && move[1] >= 0 && move[0] <= 7 && move[1] <= 7
#         updated_array.push(move)
#       end
#     end
#     updated_array
#   end
# end

# class Cell
#   attr_reader :data
#   def initialize(data)
#     @data = data
#   end

# end

# x = Board.new
# x.knight_moves([3,3],[4,3])

# --- Solution By: qpongratz ---
# Controls what move nodes keep track of
class MoveNode
  attr_reader :position, :parent
  TRANSFORMATIONS = [[1, 2], [-2, -1], [-1, 2], [2, -1],
                      [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze

  @@history = []

  def initialize(position, parent)
    @position = position
    @parent = parent
    @@history.push(position)
  end

  def children
    TRANSFORMATIONS.map { |t| [@position[0] + t[0], @position[1] + t[1]]}
                    .keep_if { |e| MoveNode.valid?(e)}
                    .reject { |e| @@history.include?(e)}
                    .map { |e| MoveNode.new(e, self)}
  end

  def self.valid?(position)
    position[0].between?(1, 8) && position[1].between?(1, 8)
  end
end

def display_parent(node)
  display_parent(node.parent) unless node.parent.nil?
  p node.position
end

def knight_moves(start_pos, end_position)
  queue = []
  current_node = MoveNode.new(start_pos, nil)
  until current_node.position == end_position
    current_node.children.each { |child| queue.push(child)}
    current_node = queue.shift
  end
  display_parent(current_node)
end

knight_moves([3, 3], [4, 3])