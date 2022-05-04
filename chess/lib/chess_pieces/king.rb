class King
  attr_reader :name, :symbol, :team
  def initialize(team)
    @name = "King"
    if team == "white"
      @symbol = "♔"
    else
      @symbol = "♚"
    end
    @team = team
  end
end