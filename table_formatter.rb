require 'stringio'

class TableFormatter
  def initialize(values, cols = nil, rows = nil)
    @cols = cols || values[values.keys[0]].keys
    @rows = rows || values.keys
    @values = values
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

  def col_padding(col)
    @values[col].values.max.to_s.length
  end

  def cols_string
    @cols.map { |c| "%-#{col_padding(c)}s" % c }.join ' '
  end

  def print_cols(s)
    s.write ' ' * cols_padding
    s.write cols_string
  end

  def print_cols_separator(s)
    s.write ' ' * (cols_padding - 1)
    s.write '-' * (cols_string.length + 1)
  end

  def print_data(s)
    @rows.each do |r|
      s.write "%-#{largest_row_length + 1}s" % r
      s.write '| '
      @values[r].each do |c, v|
        s.write "%-#{col_padding(c)}s " % v
      end
      s.write "\n"
    end
  end
end
