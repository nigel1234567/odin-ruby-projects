require_relative 'cell'
require_relative 'player'
require_relative 'board'

class Game
  attr_accessor :board, :player_one, :player_two, :current_player
  def initialize
    @player_one = Player.new(nil, "\033[0;32m●\e[0m")
    @player_two = Player.new(nil, "\033[0;31m●\e[0m")
    puts "Welcome to a game of Connect four!"
    update_players
    puts "Let's begin!"
    @board = Board.new(@player_one, @player_two)
    @current_player = @player_one
  end

  def play
    player_turns
    game_end
  end

  def update_players
    puts "Player 1, please input your name: "
    name = gets.chomp
    @player_one.name = name
    puts "Player 2, please input your name: "
    name = gets.chomp
    @player_two.name = name
  end

  def player_turns
    until board.game_over? 
      board.display
      puts "#{@current_player.name}, please choose a column: "
      input = gets.chomp
      if input.match?(/^[1-7]$/)
        input = input.to_i 
        input -= 1
        update = board.update_board(@current_player, input)
        if update == true
          update
          if board.game_over? == false
            @current_player = switch_current_player
          end
        end
      else
        puts "Wrong input, please try again."
        sleep(1)
      end
    end
  end

  def switch_current_player
    if @current_player == @player_one
      @player_two
    else
      @player_one
    end
  end

  def game_end
    board.display
    puts "Congrats, #{@current_player.name}! You won!"
  end
end