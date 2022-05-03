require_relative '../lib/board'
require_relative '../lib/cell'

describe Board do
  subject(:board) { described_class.new }

  describe '#build_board' do
    it 'return array of empty strings' do
      board.build_board
      comparison = []
      board_array = board.board
      board_array.each do |row|
        row_array = []
        row.each do |cell|
          row_array << cell.chess_piece_symbol
        end
        comparison << row_array
      end
      result = [[' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' '],
                [' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ']]
      expect(comparison).to eq(result)
    end
  end


end