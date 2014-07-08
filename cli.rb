require_relative 'primes'
require_relative 'multiplication'
require_relative 'table_formatter'

print "Give N: "
n = STDIN.gets.strip.to_i
fail 'n <= 0' if n <= 0

puts

primes = Primes.new(n).get
table = Multiplication.new(primes).table
formatter = TableFormatter.new(table)

puts formatter.format
