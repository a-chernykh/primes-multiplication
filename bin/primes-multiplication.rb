$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'primes'
require 'multiplication'
require 'table_formatter'
require 'benchmark'

print "Give N: "
n = STDIN.gets.strip.to_i
fail 'n <= 0' if n <= 0

puts

time = Benchmark.realtime {
  primes = Primes.new(n).get
  results = Multiplication.new(primes).results
  formatter = TableFormatter.new(results, cols: primes, rows: primes)

  puts formatter.format
}

puts
puts "Finished in %.3fs" % time
