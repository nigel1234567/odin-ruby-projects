require_relative 'chess_pieces/pawn.rb'

class Cell
  attr_accessor :chess_piece_name, :chess_piece_symbol, :chess_piece_team
  attr_reader :cell_name
  def initialize(cell_name)
    @cell_name = cell_name
    @chess_piece_name = nil
    @chess_piece_symbol = ' '
    @chess_piece_team = nil
  end

  def update(name, symbol)
    @chess_piece_name = name
    @chess_piece_symbol = symbol
  end
end