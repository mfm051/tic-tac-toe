# frozen_string_literal: true

module GameHelper # :nodoc:
  def check_three_equal(set, mark1, mark2)
    if set.all?(mark1) || set.all?(mark2)
      true
    else
      false
    end
  end
end

class Game # :nodoc:
  attr_reader :player1, :player2, :current_player, :squares

  include GameHelper

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
    # complete = false
    # lines.each do |line|
    #   complete = true if line.all?(player1) || line.all?(player2)
    # end
    # complete
  end

  def check_column_complete
    complete = false
    [0, 1, 2].each do |column_index|
      column = [squares[0][column_index], squares[1][column_index], squares[2][column_index]]
      complete = true if column.all?(player1) || column.all?(player2)
    end
    complete
  end
end

# Tests
game = Game.new
game.pick_square(0, 0)
game.pick_square(1, 0)
game.pick_square(0, 1)
game.pick_square(1, 1)
game.pick_square(0, 2)
p game.squares
p game.check_line_complete
p game.check_column_complete
