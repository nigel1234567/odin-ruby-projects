class Rook
  attr_reader :name, :symbol, :team
  def initialize(team)
    @name = "Rook"
    if team == "white"
      @symbol = "♖"
    else
      @symbol = "♜"
    end
    @team = team
  end
end