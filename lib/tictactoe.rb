# frozen_string_literal: true

require_relative './board'

# :nodoc:
class TicTacToe
  def initialize(player1 = 'X', player2 = 'O')
    @current_player = player1
    @player1 = player1
    @player2 = player2
    @board = Board.new
  end

  def play
    until game_over?
      @board.show
      puts "Current player: #{@current_player}. Pick a square"
      pick_square
      rotate_player
    end
  end

  def game_over?
    @board.three_complete?(@player1) || @board.three_complete?(@player2) || @board.full?
  end

  private

  def pick_square
    square = gets.chomp.upcase
    @board.mark(square, @current_player)
  rescue ArgumentError => e
    puts e.message
    puts 'Please choose another square'
    retry
  end

  def rotate_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end
