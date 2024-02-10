# frozen_string_literal: true

require_relative '../lib/tictactoe'
require_relative '../lib/board'

describe TicTacToe do
  subject(:game) { described_class.new }
  let(:board) { game.instance_variable_get(:@board) }

  describe '::initialize' do
    it 'sends message to create a Board' do
      expect(Board).to receive(:new)
      described_class.new
    end
  end

  describe '#round' do
    before do
      allow(game).to receive(:gets).and_return('A1')
    end

    it 'sends message to its board to mark square' do
      expect(board).to receive(:mark)
      game.round
    end

    it 'sends message to its board to show itself' do
      expect(board).to receive(:to_s)
      game.round
    end

    it 'changes player' do
      expect { game.round }.to(change { game.instance_variable_get(:@current_player) })
    end
  end

  describe '#game_over?' do
    it 'sends message to ask if board is full' do
      expect(board).to receive(:full?)
      game.game_over?
    end

    it 'sends message to ask if board has line, column or cross complete for both players' do
      expect(board).to receive(:three_complete?).twice
      game.game_over?
    end
  end
end
