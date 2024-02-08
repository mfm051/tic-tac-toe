# frozen_string_literal: true

class Board # :nodoc:
  attr_reader :squares

  def initialize
    @squares = Array.new(3) { Array.new(3) }
  end

  def square_available?(square)
    line = line(square)
    column = column(square)
    squares[line][column].nil?
  end

  def pick(square, mark)
    line = line(square)
    column = column(square)
    squares[line][column] = mark
  end

  def line_equal?(option1, option2)
    lines = [squares[0], squares[1], squares[2]]
    lines.any? { |line| line.all?(option1) || line.all?(option2) }
  end

  def column_equal?(option1, option2)
    columns = squares.transpose
    columns.any? { |column| column.all?(option1) || column.all?(option2) }
  end

  def cross_equal?(option1, option2)
    crosses = [(0..2).map { |i| squares[i][i] }, (0..2).map { |i| squares[i][2 - i] }]
    crosses.any? { |cross| cross.all?(option1) || cross.all?(option2) }
  end

  def complete?
    squares.flatten.all?
  end

  def show
    puts "    A    B    C  \n1 #{squares[0]}\n2 #{squares[1]}\n3 #{squares[2]}\n\n"
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
end
