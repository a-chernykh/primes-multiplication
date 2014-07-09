require 'multiplication'
require 'benchmark'

describe Multiplication do
  describe '#results' do
    let(:numbers) { [1, 2, 3, 4, 5] }
    subject(:results) { described_class.new(numbers).results }

    it 'is an upper right triangle of multiplication results' do
      expect(results).to eq [[1, 2, 3, 4, 5], [4, 6, 8, 10], [9, 12, 15], [16, 20], [25]]
    end

    it 'can handle big tables', performance: true do
      multiplication = described_class.new((1..5_000).to_a)
      expect(Benchmark.realtime { multiplication.results }).to be < 2
    end
  end
end
