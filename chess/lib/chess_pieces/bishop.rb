class Bishop
  attr_reader :name, :symbol, :team
  def initialize(team)
    @name = "Bishop"
    if team == "white"
      @symbol = "♗"
    else
      @symbol = "♝"
    end
    @team = team
  end
end