class Board
  def initialize
    @grid = Array.new(3) { Array.new(3, " ") }
  end

  def display
    @grid.each { |row| puts row.join(" | ") }
  end

  def update_board(position, symbol)
    row, col = position
    @grid[row][col] = symbol if @grid[row][col] == " "
  end

  def win?
    # Check rows, columns, and diagonals for winning conditions
  end
end

class Player
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end
end

class Game
  def initialize
    @board = Board.new
    @player_x = Player.new("X")
    @player_o = Player.new("O")
    @current_player = @player_x
  end

  def play
    loop do
      @board.display
      move = get_player_move
      @board.update_board(move, @current_player.symbol)
      if @board.win?
        puts "Player #{@current_player.symbol} wins!"
        break
      end
      switch_players
    end
  end

  def get_player_move
    # Get and validate player's move
  end

  def switch_players
    @current_player = @current_player == @player_x ? @player_o : @player_x
  end
end
.