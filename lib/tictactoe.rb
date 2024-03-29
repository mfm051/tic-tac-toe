# frozen_string_literal: true

require_relative './board'

# :nodoc:
class TicTacToe
  attr_reader :board

  def initialize(player1 = 'X', player2 = 'O')
    @current_player = player1
    @player1 = player1
    @player2 = player2
    @board = Board.new
  end

  def self.play
    game = TicTacToe.new
    game.round until game.game_over?
    puts game.board
  end

  def round
    puts @board
    puts "Current player: #{@current_player}. Pick a square"
    pick_square
    rotate_player
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
