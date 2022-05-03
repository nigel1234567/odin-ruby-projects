require_relative '../lib/board'
require_relative '../lib/player'

describe Board do
  
  describe "#game_over?" do
    let(:cells) {board.instance_variable_get(:@cells)}
    player_one = Player.new('One', 'X')
    player_two = Player.new('Two', 'O')
    subject(:board) { described_class.new(player_one, player_two)}
    
    before do
    board.create_cells
    @cells[0][0] = "X"
    @cells[0][1] = "X"
    @cells[0][2] = "X"
    @cells[0][3] = "X"
    end

    context "when one player gets horizontal win" do
      it 'returns true' do
        result = board.win_horizontal
        expect(result).to be true
      end
    end
  end
end