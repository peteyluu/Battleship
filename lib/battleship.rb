require_relative 'player.rb'
require_relative 'board.rb'

class BattleshipGame

  attr_reader :player, :board, :ships

  def initialize(player, board)
    @player = player
    @board = board
    @hit = false
    @ships = 10
  end

  def play
    puts "Welcome to Battleship!"
    beg = false
    until game_over?
      system('clear')
      board.display
      if beg
        display_status
      end
      play_turn
      beg = true
    end

    puts "You win!"
  end

  def display_status
    if @hit
      puts "It's a hit!"
    else
      puts "It's not a hit!"
    end

    puts "There are #{ships} ships remaining."
  end

  def attack(pos)
    if board[pos] == :s
      @hit = true
      @ships -= 1
    else
      @hit = false
    end

    board[pos] = :x
  end

  def count
    board.count
  end

  def game_over?
    board.won?
  end

  def play_turn
    pos = player.get_play
    until valid_play?(pos)
      pos = player.get_play
    end
    attack(pos)
  end

  def valid_play?(pos)
    pos.is_a?(Array) && in_range?(pos)
  end

  def in_range?(pos)
    x, y = pos
    x.between?(0, 9) && y.between?(0, 9)
  end
end

if __FILE__ == $PROGRAM_NAME
  player = HumanPlayer.new("peter")
  board = Board.new
  game = BattleshipGame.new(player, board)
  game.play
end
