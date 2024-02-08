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

  describe '#game_over?' do
    let(:board) { game.instance_variable_get(:@board) }

    context 'when board is full (draw)' do
      before do
        allow(board).to receive(:full?).and_return(true)
      end

      it 'returns true' do
        expect(game.game_over?).to eq(true)
      end
    end

    context 'when a line is full' do
      before do
        allow(board).to receive(:line_full?).and_return(true)
      end

      it 'returns true' do
        expect(game.game_over?).to eq(true)
      end
    end

    context 'when a column is full' do
      before do
        allow(board).to receive(:column_full?).and_return(true)
      end

      it 'returns true' do
        expect(game.game_over?).to eq(true)
      end
    end

    context 'when a cross is full' do
      before do
        allow(board).to receive(:cross_full?).and_return(true)
      end

      it 'returns true' do
        expect(game.game_over?).to eq(true)
      end
    end

    context 'when there is neither a draw nor any trio' do
      before do
        allow(board).to receive(:full?).and_return(false)
        allow(board).to receive(:line_full?).and_return(false)
        allow(board).to receive(:column_full?).and_return(false)
        allow(board).to receive(:cross_full?).and_return(false)
      end

      it 'returns false' do
        expect(game.game_over?).to eq(false)
      end
    end
  end
end
