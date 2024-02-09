# frozen_string_literal: true

# :nodoc:
class Board
  def initialize
    @squares = Array.new(3) { Array.new(3) }
  end

  def square_available?(square)
    line = line(square)
    column = column(square)
    @squares[line][column].nil?
  end

  def mark(square, mark)
    raise ArgumentError, 'Out of board!' unless ('A'..'C').include?(square[0]) && ('1'..'3').include?(square[1])
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

  def show
    puts "    A    B    C  \n1 #{@squares[0]}\n2 #{@squares[1]}\n3 #{@squares[2]}\n\n"
  end

  private

  def line(square_code)
    line_num = square_code.downcase.split('')[1].to_i - 1
    [0, 1, 2].any?(line_num) ? line_num : [0, 1, 2].sample
  end

  def column(square_code)
    case square_code.downcase.split('')[0]
    when 'a' then 0
    when 'b' then 1
    when 'c' then 2
    else [0, 1, 2].sample
    end
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
