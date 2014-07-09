require 'multiplication'
require 'benchmark'

describe Multiplication do
  describe '#results' do
    let(:numbers) { [1, 2, 3, 4, 5] }
    subject(:results) { described_class.new(numbers).results }

    it 'is an array of multiplication results' do
      expect(results).to eq [[1, 2, 3, 4, 5], [2, 4, 6, 8, 10], [3, 6, 9, 12, 15], [4, 8, 12, 16, 20], [5, 10, 15, 20, 25]]
    end

    it 'can handle big tables', performance: true do
      multiplication = described_class.new((1..5_000).to_a)
      expect(Benchmark.realtime { multiplication.results }).to be < 4
    end
  end
end
