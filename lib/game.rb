# frozen_string_literal: true

# :nodoc:
class Game
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
    end_game if winner? || board.complete?
  end

  def end_game
    puts "Game complete! Starting another round..\n\n"
    initialize
  end

  private

  def rotate_player
    @current_player = current_player == player1 ? player2 : player1
  end

  def winner?
    board.column_equal?(player1, player2) || board.line_equal?(player1, player2) || board.cross_equal?(player1, player2)
  end
end
