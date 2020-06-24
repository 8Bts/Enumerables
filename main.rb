# rubocop:disable Style/CaseEquality
# rubocop:disable Lint/AmbiguousBlockAssociation

module Enumerable
  def my_each
    size.times { |counter| yield(self[counter]) } if block_given?
    block_given? ? self : to_enum(__method__)
  end

  def my_each_with_index
    size.times { |counter| yield(self[counter], counter) } if block_given?
    block_given? ? self : to_enum(__method__)
  end

  def my_select
    arr = []
    if block_given?
      my_each do |elem|
        arr << elem if yield(elem)
      end
    else return to_enum(__method__)
    end
    arr
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each { |elem| return false unless yield(elem) }
    elsif pattern
      my_each { |elem| return false unless pattern === elem }
    else
      my_each { |elem| return false unless elem }
    end

    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |elem| return true if yield(elem) }
    elsif pattern
      my_each { |elem| return true if pattern === elem }
    else
      my_each { |elem| return true if elem }
    end

    false
  end

  def my_none?(pattern = nil)
    return !my_any?(pattern) if block_given? == false && pattern

    !my_any? { |elem| block_given? ? yield(elem) : elem }
  end

  def my_count(item = nil)
    sum = 0
    my_each do |elem|
      if item
        sum += 1 if elem == item
      elsif block_given?
        sum += 1 if yield(elem)
      else
        sum += 1
      end
    end
    sum
  end

  def my_map(obj = nil)
    arr = []
    if Proc === obj
      my_each { |elem| arr << obj.call(elem) }
    elsif block_given?
      my_each { |elem| arr << yield(elem) }
    else
      return to_enum(__method__)
    end
    arr
  end

  def my_inject(initial = self[0], sym = nil)
    acc = initial
    if block_given?          
      my_each_with_index do |elem, index|
        next if index.zero? && initial == self[0]
        acc = yield(acc, elem) 
      end
    elsif sym
      my_each { |elem| acc = acc.send(sym, elem) } if acc.respond_to? sym
    end
    acc
  end
end

def multiply_els(arr)
  # arr.my_inject(1, :*)
  arr.my_inject { |acc, elem| acc * elem }
end

#  =====   Method tests =====

puts 'my_each :'
[1, 2, 3, 4, 5].my_each { |elem| p elem * 2 }

puts 'my_each_with_index:'
[1, 2, 3, 4, 5].my_each_with_index { |elem, index| p "#{elem} index #{index}" }

puts 'my_select:'
puts [1, 2, 3, 4, 5].my_select(&:even?)

puts 'my_all?:'
puts [1, 2, 3, 4, 5].my_all? { |elem| elem < 6 }

puts 'my_any?:'
puts [1, 2, 3, 4, 5].my_any? { |elem| elem == 3 }

puts 'my_none?:'
puts [1, 2, 3, 4, 5].my_none? { |elem| elem > 5 }

puts 'my_count:'
puts [1, 2, 3, 4, 5].my_count { |elem| (elem % 3).zero? }

puts 'my_map:'
puts [1, 2, 3, 4, 5].my_map proc { |elem| elem * 3 }

puts 'my_inject:'
puts multiply_els([1, 2, 3, 4, 5])

# rubocop:enable Style/CaseEquality
# rubocop:enable Lint/AmbiguousBlockAssociation
