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
      expect(board).to receive(:show)
      game.round
    end

    it 'changes player' do
      expect { game.round }.to(change { game.instance_variable_get(:@current_player) })
    end
  end

  describe '#game_over?' do
    context 'when board is full (draw)' do
      before do
        allow(board).to receive(:full?).and_return(true)
      end

      it 'returns true' do
        expect(game.game_over?).to eq(true)
      end
    end

    context 'when board has line, column or cross completed' do
      before do
        allow(board).to receive(:three_complete?).and_return(true)
      end

      it 'returns true' do
        expect(game.game_over?).to eq(true)
      end
    end

    context 'when board has neither a trio nor is full' do
      before do
        allow(board).to receive(:full?).and_return(false)
        allow(board).to receive(:three_complete?).and_return(false)
      end

      it 'returns false' do
        expect(game.game_over?).to eq(false)
      end
    end
  end
end
