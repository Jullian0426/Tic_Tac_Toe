class Board
  def initialize
    @grid = Array.new(3) { Array.new(3, " ") }
  end

  def display
    puts "+---+---+---+"
    @grid.each do |row|
      puts "| #{row.join(' | ')} |"
      puts "+---+---+---+"
    end
  end

  def update_board(row, col, symbol)
    if @grid[row][col] == " "
      @grid[row][col] = symbol
      return true
    else
      return false
    end
  end

  def full?
    @grid.all? { |row| row.none?(" ") }
  end

  def win?(symbol)
    # Check rows, columns, and two diagonals
    winning_positions = rows + columns + diagonals
    winning_positions.any? do |line|
      line.all? { |cell| cell == symbol }
    end
  end

  private

  def rows
    @grid
  end

  def columns
    @grid.transpose
  end

  def diagonals
    [
      [@grid[0][0], @grid[1][1], @grid[2][2]],
      [@grid[0][2], @grid[1][1], @grid[2][0]]
    ]
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
      system "clear" or system "cls"
      @board.display
      row, col = get_player_move
      if @board.update_board(row, col, @current_player.symbol)
        if @board.win?(@current_player.symbol)
          system "clear" or system "cls"
          @board.display
          puts "Player #{@current_player.symbol} wins!"
          break
        elsif @board.full?
          system "clear" or system "cls"
          @board.display
          puts "It's a tie!"
          break
        end
        switch_players
      else
        puts "Invalid move, please try again."
        sleep(2)
      end
    end
  end

  private

  def get_player_move
    puts "Player #{@current_player.symbol}, enter your move as 'row col':"
    move = gets.chomp.split.map(&:to_i)
    [move[0] - 1, move[1] - 1]  # Adjust for zero-indexed array
  end

  def switch_players
    @current_player = @current_player == @player_x ? @player_o : @player_x
  end
end

if __FILE__ == $0
  game = Game.new
  game.play
end