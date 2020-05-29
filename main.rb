module Enumerable

    def my_each
      self.size.times do | counter |
        if block_given?
          yield(self[counter])
          self
        else to_enum(__method__)
        end     
      end  
    end
  
    def my_each_with_index
      self.size.times do | counter |
        if block_given?
          yield(self[counter], counter)
          self
        else to_enum(__method__)
        end     
      end  
    end

    def my_select
        arr = []
        if block_given?
          self.my_each do | elem |   
            arr << elem if yield(elem)
          end
        else to_enum(__method__)
        end
        arr  
      end
  
end

def multiply_els(arr)
    #arr.my_inject(1, :*)
    arr.my_inject { |acc, elem| acc*elem }
end
  
