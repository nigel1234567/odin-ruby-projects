require_relative '../lib/board'
require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new() }
  let(:board) { instance_double(Board) }
end