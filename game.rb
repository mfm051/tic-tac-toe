# frozen_string_literal: true

class Board # :nodoc:
  attr_reader :squares

  def initialize
    @squares = Array.new(3) { Array.new(3) }
  end

  def pick(line, column, mark)
    return false if squares[line][column].nil? == false

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

  def show
    "    A    B    C  \n1 #{squares[0]}\n2 #{squares[1]}\n3 #{squares[2]}\n\n"
  end
end

class Game # :nodoc:
  # attr_reader :player1, :player2, :current_player, :squares
  attr_reader :player1, :player2, :current_player, :board

  def initialize(player1 = 'X', player2 = 'O')
    @current_player = player1
    @player1 = player1
    @player2 = player2
    @board = Board.new
    # @squares = Array.new(3) { Array.new(3) }
  end

  def round(line, column)
    board.pick(line, column, current_player)
    board.show
    if complete?
      puts "#{current_player} wins!"
    else
      rotate_player
    end
  end

  def rotate_player
    @current_player = current_player == player1 ? player2 : player1
  end

  # def pick_square(line, column)
  #   return if squares[line][column].nil? == false

  #   squares[line][column] = current_player
  # end

  # def check_line_complete
  #   lines = [squares[0], squares[1], squares[2]]
  #   lines.any? { |line| line.all?(player1) || line.all?(player2) }
  # end

  # def check_column_complete
  #   columns = squares.transpose
  #   columns.any? { |column| column.all?(player1) || column.all?(player2) }
  # end

  # def check_cross_complete
  #   crosses = [(0..2).map { |i| squares[i][i] }, (0..2).map { |i| squares[i][2 - i] }]
  #   crosses.any? { |cross| cross.all?(player1) || cross.all?(player2) }
  # end

  def complete?
    board.column_equal?(player1, player2) || board.line_equal?(player1, player2) || board.cross_equal?(player1, player2)
  end

  # def board
  #   "    A    B    C  \n1 #{squares[0]}\n2 #{squares[1]}\n3 #{squares[2]}\n\n"
  # end
end

# Tests
game = Game.new
game.round(1, 1)
game.round(0, 0)
