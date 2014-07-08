class Multiplication
  def initialize(numbers)
    @numbers = numbers
  end

  def table
    @table ||= calculate
  end

  private

  def calculate
    table = {}

    (0...@numbers.length).each do |i|
      n1 = @numbers[i]

      (i...@numbers.length).each do |j|
        n2 = @numbers[j]

        table[n1] ||= {}
        table[n2] ||= {}

        table[n1][n2] ||= n1 * n2
        table[n2][n1] ||= n1 * n2
      end
    end

    table
  end
end
