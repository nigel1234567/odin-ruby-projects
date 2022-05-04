class Knight
  attr_reader :name, :symbol, :team
  def initialize(team)
    @name = "Knight"
    if team == "white"
      @symbol = "♘"
    else
      @symbol = "♞"
    end
    @team = team
  end
end