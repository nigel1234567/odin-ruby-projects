class Pawn
  attr_reader :name, :symbol, :team
  def initialize(team)
    @name = "Pawn"
    if team == "white"
      @symbol = "♙"
    else
      @symbol = "♟"
    end
    @team = team
  end
end