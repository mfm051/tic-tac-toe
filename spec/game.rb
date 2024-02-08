# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'

describe Game do
  subject(:game) { described_class.new }

  describe '::initialize' do
    it 'sends message to create a Board' do
      expect(Board).to receive(:new)
      Game.new
    end
  end

  describe '#round' do
    let(:board) { game.instance_variable_get(:@board) }

    it 'sends message to its board to check if given square is available' do
      square = 'A1'
      expect(board).to receive(:square_available?).with(square)
      game.round(square)
    end

    it 'sends message to its board to mark square' do
      square = 'A1'
      mark = game.instance_variable_get(:@current_player)
      expect(board).to receive(:pick).with(square, mark)
      game.round(square)
    end

    it 'sends message to its board to show itself' do
      square = 'A1'
      expect(board).to receive(:show)
      game.round(square)
    end

    it 'changes player' do
      square = 'A1'
      expect { game.round(square) }.to(change { game.instance_variable_get(:@current_player) })
    end
  end

  describe '#end_game' do
    it 'restarts board' do
      expect { game.end_game }.to(change { game.instance_variable_get(:@board) })
    end

    it 'makes player1 the next player' do
      player1 = game.instance_variable_get(:@player1)
      game.end_game
      expect(game.instance_variable_get(:@current_player)).to eq(player1)
    end
  end
end
