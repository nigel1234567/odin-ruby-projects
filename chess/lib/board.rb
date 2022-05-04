require_relative 'cell'
require_relative 'chess_pieces/pawn'
require_relative 'chess_pieces/queen'


class Board
  attr_accessor :board

  LETTERS = ['A','B','C','D','E','F','G','H']

  def initialize
    @board = build_board
    @chosen_cell = nil
  end

  def build_board
    # Create rows of board
    num_array = *(0..7)
    board_array = []
    i = 0
    while i < num_array.length
      j = 0
      row_array = []
      while j < num_array.length
        data = [num_array[i], num_array[j]]
        row_num = i+1
        cell = LETTERS[j]+row_num.to_s
        row_array.push(Cell.new(cell))
        j += 1
      end
      board_array << row_array
      i += 1
    end
    board_array
  end

  def show
    # Show UI of board
    puts "    A   B   C   D   E   F   G   H  "
    puts "   ___ ___ ___ ___ ___ ___ ___ ___ "
    @board.each_with_index do |row, index|
      puts "#{index+1} | #{row[0].chess_piece_symbol} | #{row[1].chess_piece_symbol} | #{row[2].chess_piece_symbol} | #{row[3].chess_piece_symbol} | #{row[4].chess_piece_symbol} | #{row[5].chess_piece_symbol} | #{row[6].chess_piece_symbol} | #{row[7].chess_piece_symbol} |"
      puts "  |___|___|___|___|___|___|___|___|"
    end
  end

  # Update individual cells
  def update(cell, piece)
    # Get name and symbol of chess piece
    name = piece.name
    symbol = piece.symbol
    team = piece.team
    # Select cell to update
    array = cell.split('')
    @chosen_cell = @board[array[1].to_i - 1][LETTERS.index(array[0])]
    # Update chosen cell
    @chosen_cell.chess_piece_name = name
    @chosen_cell.chess_piece_symbol = symbol
    @chosen_cell.chess_piece_team = team

    # Check if pawn evolve to queen
    if pawn_queen?(@chosen_cell, piece)
      piece = Queen.new(team)
      update(@chosen_cell.cell_name, piece)
    end

  end

  # Check if pawn evolve to queen
  def pawn_queen?(chosen_cell, piece)
    name = piece.name
    symbol = piece.symbol
    team = piece.team
    if name == "Pawn" && team == "white" && chosen_cell.cell_name.include?('1')
      true
    elsif name == "Pawn" && team == "black" && chosen_cell.cell_name.include?('8')
      true
    else
      false
    end
  end

  def generate_pieces
    w = "white"
    b = "black"
    board_array = @board
    # Generate pawns
    current_row = board_array[1] # Black team
    current_row.each do |cell| 
      update(cell.cell_name, Pawn.new(b))
    end
    current_row = board_array[6] # White team
    current_row.each do |cell|
      update(cell.cell_name, Pawn.new(w))
    end
    # Generate knights

    # Generate rooks

    # Generate bishops

    # Generate queens
    current_row = board_array[0] # Black team
    current_cell = current_row[3]
    update(current_cell.cell_name, Queen.new(b))

    current_row = board_array[7] # White team
    current_cell = current_row[3]
    update(current_cell.cell_name, Queen.new(w))
    # Generate kings
  end
end

x = Board.new
x.board
y = Pawn.new("black")
x.generate_pieces
x.show
# x.update('A7', y)
# x.show
# x.update('A8', y)
# x.show
