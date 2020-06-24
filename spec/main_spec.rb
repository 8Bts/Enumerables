# spec/main_spec.rb

require './main'

describe Enumerable do
  describe '#my_each' do
    it 'iterates through each element of collection' do
      expect { |b| [1, 4, 6, 7].my_each(&b) }.to yield_successive_args(1, 4, 6, 7)
    end

    it 'returns the array itself if block was given' do
      arr = [1, 2, 3, 4]
      expect(arr.my_each { |e| }).to eql(arr)
    end

    it 'returns Enumerator if block was not given' do
      arr = [1, 2, 3, 4]
      expect(arr.my_each.class.name).to eql('Enumerator')
    end
  end

  describe '#my_each_with_index' do
    it 'iterates through each element of collection with index' do
      expect { |b| [1, 4, 6, 7].my_each_with_index(&b) }.to yield_successive_args([1, 0], [4, 1], [6, 2], [7, 3])
    end

    it 'returns the array itself if block was given' do
      arr = [1, 2, 3, 4]
      expect(arr.my_each_with_index { |e| }).to eql(arr)
    end

    it 'returns Enumerator if block was not given' do
      arr = [1, 2, 3, 4]
      expect(arr.my_each_with_index.class.name).to eql('Enumerator')
    end
  end

  describe '#my_select' do
    it 'returns the array of elements which satisfies the condition if block passed' do
      arr = [1, 2, 3, 4]
      expect(arr.my_select { |elem| elem > 2 }).to eql([3, 4])
    end

    it 'returns Enumerator if block was not given' do
      arr = [1, 2, 3, 4]
      expect(arr.my_select.class.name).to eql('Enumerator')
    end
  end

  describe '#my_all?' do
    it 'returns true if the condition passed by block is always true' do
      arr = [1, 2, 3, 4]
      expect(arr.my_all? { |elem| elem > 0 }).to be_truthy
    end

    it 'returns false if the condition passed by block is not always true' do
      arr = [1, 2, 3, 4]
      expect(arr.my_all?(&:even?)).to be_falsey
    end

    it 'returns true if the pattern was passed instead and it is always true' do
      arr = [1, 2, 3, 4]
      expect(arr.my_all?(Numeric)).to be_truthy
    end

    it 'returns false if the pattern was passed instead and it is not always true' do
      arr = [1, 2, 3, 4]
      expect(arr.my_all?(:odd?)).to be_falsey
    end

    it 'returns true if the block is not given and none of the elements of the collection are false or nil' do
      arr = [1, 2, 3, 4]
      expect(arr.my_all?).to be_truthy
    end

    it 'returns false if the block is not given and any of the elements of the collection is false or nil' do
      arr = [1, 2, 3, false, 4]
      expect(arr.my_all?).to be_falsey
    end
  end
end
