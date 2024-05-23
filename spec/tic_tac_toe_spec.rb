require 'rspec'
require_relative '../tic_tac_toe'

RSpec.describe Board do
  let(:board) { Board.new }

  describe '#initialize' do
    it 'initializes an empty 3x3 grid' do
      expect(board.instance_variable_get(:@grid)).to eq(Array.new(3) { Array.new(3, " ") })
    end
  end

  describe '#display' do
    it 'displays the board' do
      expect { board.display }.to output("+---+---+---+\n|   |   |   |\n+---+---+---+\n|   |   |   |\n+---+---+---+\n|   |   |   |\n+---+---+---+\n").to_stdout
    end
  end

  describe '#update_board' do
    it 'updates the board at the given position with the symbol' do
      expect(board.update_board(0, 0, 'X')).to be true
      expect(board.instance_variable_get(:@grid)[0][0]).to eq('X')
    end

    it 'returns false if the position is already occupied' do
      board.update_board(0, 0, 'X')
      expect(board.update_board(0, 0, 'O')).to be false
    end
  end

  describe '#full?' do
    it 'returns false if the board is not full' do
      expect(board.full?).to be false
    end

    it 'returns true if the board is full' do
      3.times do |row|
        3.times do |col|
          board.update_board(row, col, 'X')
        end
      end
      expect(board.full?).to be true
    end
  end

  describe '#win?' do
    it 'returns true if there is a winning row' do
      3.times { |i| board.update_board(0, i, 'X') }
      expect(board.win?('X')).to be true
    end

    it 'returns true if there is a winning column' do
      3.times { |i| board.update_board(i, 0, 'X') }
      expect(board.win?('X')).to be true
    end

    it 'returns true if there is a winning diagonal' do
      3.times { |i| board.update_board(i, i, 'X') }
      expect(board.win?('X')).to be true
    end

    it 'returns false if there is no winning line' do
      expect(board.win?('X')).to be false
    end
  end
end

RSpec.describe Player do
  let(:player) { Player.new('X') }

  describe '#initialize' do
    it 'initializes with a symbol' do
      expect(player.symbol).to eq('X')
    end
  end
end

RSpec.describe Game do
  let(:game) { Game.new }

  describe '#initialize' do
    it 'initializes a new board and players' do
      expect(game.instance_variable_get(:@board)).to be_a(Board)
      expect(game.instance_variable_get(:@player_x)).to be_a(Player)
      expect(game.instance_variable_get(:@player_o)).to be_a(Player)
      expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@player_x))
    end
  end

  describe '#play' do
    it 'runs the play method without errors' do
      allow(game).to receive(:play)
      expect { game.play }.not_to raise_error
    end
  end

  describe '#get_player_move' do
    it 'gets the player move and adjusts for zero-indexed array' do
      allow(game).to receive(:gets).and_return("1 1\n")
      expect(game.send(:get_player_move)).to eq([0, 0])
    end
  end

  describe '#switch_players' do
    it 'switches the current player from X to O' do
      game.send(:switch_players)
      expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@player_o))
    end

    it 'switches the current player from O to X' do
      game.send(:switch_players)
      game.send(:switch_players)
      expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@player_x))
    end
  end
end