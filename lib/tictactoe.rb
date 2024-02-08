# frozen_string_literal: true

# :nodoc:
class TicTacToe
  attr_reader :player1, :player2, :current_player, :board

  def initialize(player1 = 'X', player2 = 'O')
    @current_player = player1
    @player1 = player1
    @player2 = player2
    @board = Board.new
  end

  def round(square)
    return puts "Square not available!\n\n" if board.square_available?(square) == false

    board.pick(square, current_player)
    board.show
    rotate_player
  end

  def game_over?
    winner? || board.full?
  end

  private

  def winner?
    [@player1, @player2].any? do |player_mark|
      board.line_full?(player_mark) || board.column_full?(player_mark) || board.cross_full?(player_mark)
    end
  end

  def rotate_player
    @current_player = current_player == player1 ? player2 : player1
  end
end
