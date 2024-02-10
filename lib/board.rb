# frozen_string_literal: true

# :nodoc:
class Board
  def initialize
    @squares = Array.new(3) { Array.new(3) }
  end

  def square_available?(square)
    line = line(square)
    column = column(square)

    return false if line.nil? || column.nil?

    @squares[line][column].nil?
  end

  def mark(square, mark)
    raise ArgumentError, 'Square unavailable' unless square_available?(square)

    line = line(square)
    column = column(square)
    @squares[line][column] = mark
  end

  def three_complete?(mark)
    line_full?(mark) || column_full?(mark) || cross_full?(mark)
  end

  def full?
    @squares.flatten.all?
  end

  def to_s
    line1, line2, line3 = @squares.map { |line| line.map { |i| i.to_s.rjust(1) }.join(' ') }

    <<~BOARD
        A B C
      1 #{line1}
      2 #{line2}
      3 #{line3}
    BOARD
  end

  private

  def line(square)
    line_input = square[1].to_i - 1
    (0..2).include?(line_input) ? line_input : nil
  end

  def column(square)
    column_indexes = { 'A' => 0, 'B' => 1, 'C' => 2 }
    column_indexes[square[0].upcase]
  end

  def line_full?(mark)
    lines = [@squares[0], @squares[1], @squares[2]]
    lines.any? { |line| line.all?(mark) }
  end

  def column_full?(mark)
    columns = @squares.transpose
    columns.any? { |column| column.all?(mark) }
  end

  def cross_full?(mark)
    crosses = [(0..2).map { |i| @squares[i][i] }, (0..2).map { |i| @squares[i][2 - i] }]
    crosses.any? { |cross| cross.all?(mark) }
  end
end
