require_relative 'player'
require_relative 'board'

class Game
  attr_accessor :first_player, :second_player, :current_player, :board
  CELLS = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8",
    "B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8",
    "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8",
    "D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8",
    "E1", "E2", "E3", "E4", "E5", "E6", "E7", "E8",
    "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8",
    "G1", "G2", "G3", "G4", "G5", "G6", "G7", "G8",
    "H1", "H2", "H3", "H4", "H5", "H6", "H7", "H8"
    ]

    LETTERS = ['A','B','C','D','E','F','G','H']

  def initialize
    @first_player = nil
    @second_player = nil
    @current_player = nil
    @board = Board.new
  end

  def update_players
    puts "Player 1, please input your name: "
    name = gets.chomp
    @first_player = Player.new(name, "white")
    puts "#{@first_player.name}, you are in the #{@first_player.team} team.\n\n"
    puts "Player 2, please input your name: "
    name = gets.chomp
    @second_player = Player.new(name, "black")
    puts "#{@second_player.name}, you are in the #{@second_player.team} team.\n\n"
  end

  def play
    puts "Welcome to a game of chess!"
    update_players
    @current_player = @first_player
    turn(@current_player)
  end

  # Player turn
  def turn(player)
    turn_over = false
    while turn_over == false
    # Player choose cell
      puts "#{player.name}'s turn."
      puts "Please select a cell: "
      chosen_cell = gets.chomp
        # Check if selection is valid
      if valid_selection?(player, chosen_cell.upcase)
        # Player choose new cell
        
        # Update new cell
        
        # Remove old cell
        
        turn_over = true
      else
        puts "Invalid selection. Please try again.\n\n"
      end
    end
  end

  # Check that selected cell is not empty, within range of cells, and is player's team
  def valid_selection?(player, cell)
    # Teams
    team = player.team
    if CELLS.include?(cell) 
      # Select cell
      array = cell.split('')
      chosen_cell = @board.board[array[1].to_i - 1][LETTERS.index(array[0])]
      if chosen_cell.chess_piece_name != nil
        if chosen_cell.chess_piece_team == team
          return true
        end
      end
    end
    return false
  end

end

x = Game.new
y = Pawn.new("white")
x.board.update('A1', y)
z = Pawn.new("black")
x.board.update('A2', z)
x.play