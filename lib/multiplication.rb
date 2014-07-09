require 'benchmark'

class Multiplication
  def initialize(numbers)
    @numbers = numbers
  end

  def results
    @results ||= calculate
  end

  private

  def calculate
    results = []

    row = 0
    while row < @numbers.length
      results[row] = []
      n1 = @numbers[row]
      col = row

      while col < @numbers.length
        n2 = @numbers[col]
        results[row] << n1 * n2
        col += 1
      end

      row += 1
    end

    results
  end
end
