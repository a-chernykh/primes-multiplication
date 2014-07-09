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
    @largest_row_length ||= @rows.map { |r| r.to_s.length }.max
  end

  def cols_padding
    largest_row_length + 3
  end

  def col_padding(col_index)
    @col_padding ||= {}
    @col_padding[col_index] ||= (0...@rows.length).map { |row| value_for(row, col_index).to_s.length }.max
  end

  def cols_string
    @cols_string ||= @cols.each_with_index.map { |name, number| "%-#{col_padding(number)}s" % name }.join ' '
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
    row = 0
    while row < @rows.length
      s.write "%-#{largest_row_length + 1}s| " % @rows[row]

      col = 0
      while col < @cols.length
        s.write "%-#{col_padding(col)}s " % value_for(row, col)
        col += 1
      end

      s.write "\n"
      row += 1
    end
  end
end
