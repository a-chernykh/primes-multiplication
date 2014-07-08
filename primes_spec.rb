require_relative 'primes'
require 'benchmark'

describe Primes do
  describe '#get' do
    let(:primes) { [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101] }

    it 'returns first prime' do
      expect(described_class.new(1).get).to eq [2]
    end

    it 'returns first 10 primes' do
      expect(described_class.new(10).get).to eq primes.first(10)
    end

    it 'returns first 15 primes' do
      expect(described_class.new(15).get).to eq primes.first(15)
    end

    it 'returns first 10,000 primes' do
      expect(described_class.new(10_000).get.length).to eq 10_000
    end

    it 'returns first 1,000,000 primes in 5 seconds' do
      time = Benchmark.realtime { @primes = described_class.new(1_000_000).get }
      expect(@primes.length).to eq 1_000_000
      expect(time).to be < 5
    end
  end
end
