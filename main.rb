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

  def my_all?(pattern = nil)
    if block_given?
      self.my_each { |elem| return false unless yield(elem) }
    elsif pattern
      self.my_each { |elem| return false unless pattern === elem } 
    else
      self.my_each { |elem| return false unless elem }
    end

    true

  end
    
  def my_any?(pattern = nil)
    if block_given?
        self.my_each { |elem| return true if yield(elem) }
    elsif pattern
        self.my_each { |elem| return true if pattern === elem } 
    else
        self.my_each { |elem| return true if elem }
    end

    false

  end

  def my_none?(pattern = nil)
    return !self.my_any?(pattern) if (block_given? == false && pattern)
    !self.my_any? { |elem| block_given?? yield(elem): elem }
  end
  
  def my_count(item = nil)
    sum = 0
    self.my_each do |elem| 
      if item
        sum += 1 if elem == item
      elsif block_given?
        sum += 1 if yield(elem)
      else
        sum+=1
      end      
    end
    sum
  end

  def my_map( obj = nil )
    arr = []
    if Proc === obj
      p "proc called"
      self.my_each { |elem| arr << obj.call(elem) }
    elsif block_given?
      self.my_each { |elem| arr << yield(elem) }
    else
      to_enum(__method__)
    end  
    arr
  end
  
end

def multiply_els(arr)
  #arr.my_inject(1, :*)
  arr.my_inject { |acc, elem| acc*elem }
end
  
