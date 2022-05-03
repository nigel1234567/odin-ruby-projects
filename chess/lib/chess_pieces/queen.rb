class Queen
  attr_reader :name, :symbol, :team
  def initialize(team)
    @name = "Queen"
    if team == "white"
      @symbol = "♕"
    else
      @symbol = "♛"
    end
    @team = team
  end
end