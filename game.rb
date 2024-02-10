# frozen_string_literal: true

require_relative './lib/tictactoe'

puts "  --TIC-TAC-TOE!--\n\n"

continue_game = true

while continue_game
  TicTacToe.play

  puts 'Keep playing? [y/n]:'
  continue_game = false if gets.chomp == 'n'
end

puts 'Thanks for playing!'
