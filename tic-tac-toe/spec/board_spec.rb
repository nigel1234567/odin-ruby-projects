require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  context 'when updating value on board' do
    symbol = 'X'
    number = 2
    it 'returns respective symbol (X)' do
      expect(board.update_board(number, symbol))
    end
  end

  context 'when game is over' do
    it 'return true if game is over' do
      results = ['X', 'X', 'X', 'O', 'O', 'X', 'X', 'O', 'O']
      results.each_with_index do |symbol, index|
        board.update_board(index, symbol)
      end
      expect(board.game_over?).to eq(true)
    end
  end

end
