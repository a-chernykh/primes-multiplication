require_relative 'multiplication'

describe Multiplication do
  describe '#table' do
    let(:numbers) { [1, 2, 3, 4, 5] }
    subject(:table) { described_class.new(numbers).table }

    it 'has 5 rows' do
      expect(table.keys.length).to eq 5
    end

    it 'has 5 cols' do
      expect(table[1].keys.length).to eq 5
    end

    it 'has correct diagonal' do
      diagonal = numbers.map { |n| table[n][n] }
      expect(diagonal).to eq numbers.map { |n| n * n }
    end
  end
end
