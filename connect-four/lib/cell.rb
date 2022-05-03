class Cell
  attr_reader :symbol, :player
  def initialize
    @symbol = "○"
    @player = nil
  end

  def update(player, symbol)
    @player = player
    @symbol = symbol
  end

end