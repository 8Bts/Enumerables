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

  describe '#my_any?' do
    it 'returns true if the block ever returns true' do
      arr = [1, 2, 3, 4]
      expect(arr.my_any? { |elem| elem > 2 }).to be_truthy
    end

    it 'returns false if the block never returns true' do
      arr = [1, 2, 3, 4]
      expect(arr.my_any? { |elem| elem > 4 }).not_to be_truthy
    end

    it 'returns true if the pattern was passed instead and ever returns true' do
      arr = ['a', 2, 's', 4]
      expect(arr.my_any?(Numeric)).to be_truthy
    end

    it 'returns false if the pattern was passed instead and it is never true' do
      arr = %w[a b c c]
      expect(arr.my_any?(Numeric)).not_to be_truthy
    end

    it 'returns true if the block is not given and any of the elements of the collection are true' do
      arr = [false, 2, 3, false]
      expect(arr.my_any?).to be_truthy
    end

    it 'returns false if the block is not given and all of the elements of the collection are false or nil' do
      arr = [false, false]
      expect(arr.my_any?).not_to be_truthy
    end
  end

  describe '#my_none?' do
    it 'returns true if the block is never true' do
      arr = [1, 2, 3, 4]
      expect(arr.my_none? { |elem| elem > 5 }).to eql true
    end

    it 'returns false if the block ever is true' do
      arr = [1, 2, 3, 4]
      expect(arr.my_none? { |elem| elem > 3 }).to eql false
    end

    it 'returns true if the pattern was passed instead and is never true' do
      arr = %w[a b s x]
      expect(arr.my_none?(Numeric)).to be true
    end

    it 'returns false if the pattern was passed instead and it is ever true' do
      arr = ['a', 'b', 2, 'r']
      expect(arr.my_none?(String)).to eql false
    end

    it 'returns true if the block is not given and all of the elements of the collection are false' do
      arr = [false, false]
      expect(arr.my_none?).to eql true
    end

    it 'returns false if the block is not given and any of the elements of the collection is true' do
      arr = [2, 3]
      expect(arr.my_none?).to eql false
    end
  end

  describe '#my_count' do
    it 'returns number of items if neither block nor an argument is given' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_count).to eql(5)
    end

    it 'when argument passed returns the number of items equal to argument in the collection' do
      arr = [1, 2, 2, 4, 5]
      expect(arr.my_count(2)).to eql(2)
    end

    it 'return number of elements yielding true when block is given' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_count(&:even?)).to eql(2)
    end
  end
end
