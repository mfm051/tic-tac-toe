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
    line = line(square)
    column = column(square)
    return puts "Square not available!\n\n" if board.square_available?(line, column) == false

    board.pick(line, column, current_player)
    board.show
    rotate_player
    end_game if winner? || board.complete?
  end

  def end_game
    puts "Game complete! Starting another round..\n\n"
    initialize
  end

  private

  def line(square_code)
    line_num = square_code.downcase.split('')[1].to_i - 1
    [0, 1, 2].any?(line_num) ? line_num : [0, 1, 2].sample
  end

  def column(square_code)
    case square_code.downcase.split('')[0]
    when 'a' then 0
    when 'b' then 1
    when 'c' then 2
    else [0, 1, 2].sample
    end
  end

  def rotate_player
    @current_player = current_player == player1 ? player2 : player1
  end

  def winner?
    board.column_equal?(player1, player2) || board.line_equal?(player1, player2) || board.cross_equal?(player1, player2)
  end
end
