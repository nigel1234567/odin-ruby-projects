# Create Player Class
class Player
  # Read player name and symbol
  attr_reader :name, :symbol

  # Initialize
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end
