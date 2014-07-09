require 'benchmark'

class Primes
  DEBUG = false

  def initialize(count)
    @count = count
  end

  # implements Sieve of Eratosthenes for generating prime numbers
  # http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
  def get
    numbers = (3..sequence_length).step(2).to_a
    p = 0

    total_time = 0

    while i = numbers.index { |n| !n.nil? && n > p }
      p = numbers[i]
      marked = false

      time_spent = Benchmark.realtime {
        start = i + p
        puts "start = %d" % start if DEBUG
        (start..sequence_length).step(p) do |i|
          if !numbers[i].nil?
            numbers[i] = nil
            marked = true
          end
        end
      }

      total_time += time_spent

      puts "p = %s %f" % [p, time_spent] if DEBUG

      break unless marked
    end

    puts "Total: %f" % total_time if DEBUG

    ([2] + numbers.compact).first(@count)
  end

  private

  def sequence_length
    # let's assume that Nth prime number is approximately N * ln(N)
    # according to http://en.wikipedia.org/wiki/Prime_number_theorem
    upper_bound = @count * Math.log(@count) + @count * Math.log(Math.log(@count))
    [2, @count, upper_bound].max.to_i
  end
end
