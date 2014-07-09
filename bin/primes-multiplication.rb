$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'primes'
require 'multiplication'
require 'table_formatter'

require 'benchmark'
require 'timeout'

$stderr.print "Give N: "
n = STDIN.gets.strip.to_i
fail 'n <= 0' if n <= 0

warn

begin
  Timeout.timeout(30) do
    time = Benchmark.realtime {
      primes = Primes.new(n).get
      results = Multiplication.new(primes).results
      formatter = TableFormatter.new(results, cols: primes, rows: primes)

      puts formatter.format
    }

    warn
    warn "Finished in %.3fs" % time
  end
rescue Timeout::Error
  warn
  warn 'We were unable to finish in a timely manner, try to give less value of N'
end
