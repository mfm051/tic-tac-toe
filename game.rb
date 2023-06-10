# frozen_string_literal: true

# class Board # :nodoc:
#   attr_reader :squares

#   def initialize
#     @squares = Array.new(3) { Array.new(3) }
#     @cross1 = [0, 1, 2].map { |i| squares[[i][i]] }
#     @cross2 = [0, 1, 2].map { |i| squares[[i][i]] }
#   end

#   def lines
#     [squares[0], squares[1], squares[2]]
#   end

#   def columns
#     squares.transpose
#   end

#   def crosses
#     [(0..2).map { |i| squares[[i][i]] }, [[0, 2], [1, 1], [2, 0]].map { |i, j| squares[i][j] }]
#   end
# end

class Game # :nodoc:
  attr_reader :player1, :player2, :current_player, :squares

  def initialize(player1 = 'X', player2 = 'O')
    @current_player = player1
    @player1 = player1
    @player2 = player2
    @squares = Array.new(3) { Array.new(3) }
  end

  def rotate_player
    @current_player =
      if current_player == player1
        player2
      else
        player1
      end
  end

  def pick_square(line, column)
    return if squares[line][column].nil? == false

    squares[line][column] = current_player
    rotate_player
  end

  def check_line_complete
    lines = [squares[0], squares[1], squares[2]]
    lines.any? { |line| line.all?(player1) || line.all?(player2) }
  end

  def check_column_complete
    columns = squares.transpose
    columns.any? { |column| column.all?(player1) || column.all?(player2) }
  end

  def check_cross_complete
    # crosses = [[squares[0][0], squares[1][1], squares[2][2]], [squares[2][0], squares[1][1], squares[0][2]]]
    crosses = [(0..2).map { |i| squares[i][i] }, (0..2).map { |i| squares[i][2 - i] }]
    crosses.any? { |cross| cross.all?(player1) || cross.all?(player2) }
  end
end

# Tests
game = Game.new
game.pick_square(0, 2)
game.pick_square(0, 1)
game.pick_square(1, 1)
game.pick_square(0, 0)
game.pick_square(2, 0)
p game.squares
p game.check_line_complete
p game.check_column_complete
p game.check_cross_complete
