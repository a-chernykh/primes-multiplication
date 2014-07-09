require 'stringio'

class TableFormatter
  def initialize(values, cols: nil, rows: nil)
    @values = values
    @cols   = cols
    @rows   = rows
  end

  def format
    s = StringIO.new

    print_cols s
    s.write "\n"

    print_cols_separator s
    s.write "\n"

    print_data s

    s.string
  end

  private

  def largest_row_length
    @rows.map { |r| r.to_s.length }.max
  end

  def cols_padding
    largest_row_length + 3
  end

  def col_padding(col_index)
    @col_padding ||= {}
    @col_padding[col_index] ||= (0...@rows.length).map { |row| value_for(row, col_index).to_s.length }.max
  end

  def cols_string
    @cols.each_with_index.map { |name, number| "%-#{col_padding(number)}s" % name }.join ' '
  end

  def print_cols(s)
    s.write ' ' * cols_padding
    s.write cols_string
  end

  def print_cols_separator(s)
    s.write ' ' * (cols_padding - 1)
    s.write '-' * (cols_string.length + 1)
  end

  def value_for(row, col)
    if col < row
      @values[col][row - col]
    else
      @values[row][col - row]
    end
  end

  def print_data(s)
    @rows.each_with_index do |r, row_index|
      s.write "%-#{largest_row_length + 1}s" % r
      s.write '| '
      (0...@cols.length).each do |col_index|
        s.write "%-#{col_padding(col_index)}s " % value_for(row_index, col_index)
      end
      s.write "\n"
    end
  end
end
