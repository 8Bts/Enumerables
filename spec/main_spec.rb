#spec/main_spec.rb

require './main'

describe Enumerable do

  describe "#my_each" do
    it "iterates through each element of collection" do
      expect { |b| [1,4,6,7].my_each(&b) }.to yield_successive_args(1, 4, 6, 7)
    end

    it "returns the array itself if block was given" do
      arr = [1,2,3,4]
      expect(arr.my_each { |e| }).to eql(arr)
    end
    
    it "returns Enumerator if block was not given" do
      arr = [1,2,3,4]
      expect(arr.my_each.class.name ).to eql("Enumerator")
    end 

  end

end

