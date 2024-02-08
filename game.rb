# frozen_string_literal: true

require_relative './lib/tictactoe'
require_relative './lib/board'

# Game interface
game = TicTacToe.new

puts "  --TIC-TAC-TOE!--\n\n"
game.board.show

puts "Enter 'end' any time to stop game\n\n"
continue_game = true

while continue_game
  puts "Current player: #{game.current_player}.\nPick a square (e.g.: 'A1')\nif out of range I'll choose RANDOMLY"
  user_choice = gets.chomp
  break if user_choice == 'end'

  puts "#{game.current_player} chooses #{user_choice}\n\n---------"
  game.round(user_choice)
end
