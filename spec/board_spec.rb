# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#square_available?' do
    context 'when square is available' do
      it 'returns true' do
        expect(board.square_available?('A1')).to eq(true)
      end
    end

    context 'when square is not available' do
      before do
        board.mark('A1', 'X')
      end

      it 'returns false' do
        expect(board.square_available?('A1')).to eq(false)
      end
    end

    context 'when square is out of board' do
      it 'returns false' do
        expect(board.square_available?('Z22')).to eq(false)
      end
    end
  end

  describe '#mark' do
    context 'when square is available' do
      it 'marks square' do
        expect { board.mark('A1', 'X') }.to change { board.instance_variable_get(:@squares)[0][0] }.from(nil).to('X')
      end
    end

    context 'when square is already marked' do
      before do
        board.mark('A1', 'X')
      end

      it 'raises an exception' do
        expect { board.mark('A1', 'O') }.to raise_error ArgumentError
      end
    end

    context 'when square is out of board' do
      it 'raises an exception' do
        expect { board.mark('Z22', 'O') }.to raise_error ArgumentError
      end
    end
  end

  describe '#three_complete?' do
    context 'when line is complete' do
      before do
        board.mark('A1', 'X')
        board.mark('B1', 'X')
        board.mark('C1', 'X')
      end

      it 'returns true' do
        expect(board.three_complete?('X')).to eq(true)
      end
    end

    context 'when column is complete' do
      before do
        board.mark('A1', 'X')
        board.mark('A2', 'X')
        board.mark('A3', 'X')
      end

      it 'returns true' do
        expect(board.three_complete?('X')).to eq(true)
      end
    end

    context 'when main diagonal is complete' do
      before do
        board.mark('A1', 'X')
        board.mark('B2', 'X')
        board.mark('C3', 'X')
      end

      it 'returns true' do
        expect(board.three_complete?('X')).to eq(true)
      end
    end

    context 'when antidiagonal is complete' do
      before do
        board.mark('A3', 'X')
        board.mark('B2', 'X')
        board.mark('C1', 'X')
      end

      it 'returns true' do
        expect(board.three_complete?('X')).to eq(true)
      end
    end

    context 'when there is no trio' do
      it 'returns false' do
        expect(board.three_complete?('X')).to eq(false)
      end
    end

    context 'when marks are different' do
      before do
        board.mark('A1', 'O')
        board.mark('B1', 'X')
        board.mark('C1', 'X')
      end

      it 'returns false' do
        expect(board.three_complete?('X')).to eq(false)
      end
    end
  end
end
