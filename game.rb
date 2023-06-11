# frozen_string_literal: true

class Board # :nodoc:
  attr_reader :squares

  def initialize
    @squares = Array.new(3) { Array.new(3) }
  end

  def square_available?(line, column)
    squares[line][column].nil?
  end

  def pick(line, column, mark)
    squares[line][column] = mark
  end

  def line_equal?(option1, option2)
    lines = [squares[0], squares[1], squares[2]]
    lines.any? { |line| line.all?(option1) || line.all?(option2) }
  end

  def column_equal?(option1, option2)
    columns = squares.transpose
    columns.any? { |column| column.all?(option1) || column.all?(option2) }
  end

  def cross_equal?(option1, option2)
    crosses = [(0..2).map { |i| squares[i][i] }, (0..2).map { |i| squares[i][2 - i] }]
    crosses.any? { |cross| cross.all?(option1) || cross.all?(option2) }
  end

  def complete?
    squares.flatten.all?
  end

  def show
    puts "    A    B    C  \n1 #{squares[0]}\n2 #{squares[1]}\n3 #{squares[2]}\n\n"
  end
end

class Game # :nodoc:
  attr_reader :player1, :player2, :current_player, :board

  def initialize(player1 = 'X', player2 = 'O')
    @current_player = player1
    @player1 = player1
    @player2 = player2
    @board = Board.new
  end

  def round(line, column)
    return puts 'Not available!' if board.square_available?(line, column) == false

    board.pick(line, column, current_player)
    board.show
    rotate_player
    end_game if winner? || board.complete?
  end

  private

  def rotate_player
    @current_player = current_player == player1 ? player2 : player1
  end

  def winner?
    board.column_equal?(player1, player2) || board.line_equal?(player1, player2) || board.cross_equal?(player1, player2)
  end

  def end_game
    puts 'Game complete'
    initialize
  end
end

# Tests
game = Game.new
game.round(0, 0)
game.round(0, 1)
game.round(0, 2)
game.round(1, 0)
game.round(1, 1)
game.round(1, 2)
game.round(2, 0)
game.round(2, 1)
game.round(2, 2)
