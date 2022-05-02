# Create class to generate board and board conditions

class Board
  # Read cell number
  attr_reader :cells

  # Board display (position)
  # 0 | 1 | 2 |
  #---+---+---
  # 3 | 4 | 5 |
  #---+---+---
  # 6 | 7 | 8 |
  #---+---+---

  WINNING_COMBOS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], 
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ].freeze

  # Board display (display)
  # 1 | 2 | 3 |
  #---+---+---
  # 4 | 5 | 6 |
  #---+---+---
  # 7 | 8 | 9 |
  #---+---+---

  def initialize
    @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  # Show board display
  # Update
  def show
    puts <<-HEREDOC

     #{cells[0]} | #{cells[1]} | #{cells[2]}
    ---+---+---
     #{cells[3]} | #{cells[4]} | #{cells[5]}
    ---+---+---
     #{cells[6]} | #{cells[7]} | #{cells[8]}
    ---+---+---
    HEREDOC
  end

  # Update board once player chooses a number
  def update_board(number, symbol)
    @cells[number] = symbol
  end

  # Check if valid move
  def valid_move?(number)
    cells[number - 1] == number
  end

  # Check if full
  def full?
    cells.all? { |cell| cell=~ /[^0-9]/} # Excludes number
  end

  # Check if game over
  def game_over?
    WINNING_COMBOS.any? do |combo|
      [cells[combo[0]], cells[combo[1]], cells[combo[2]]].uniq.length == 1
    end
  end
end

