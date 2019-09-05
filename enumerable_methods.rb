# frozen_string_literal: true
module Enumerable
 def my_each
   i = 0
    while i < size
      yield self[i]
      i += 1
    end
 end

 def my_each_with_index
  i = 0
    result = []
    while i < size
      result << yield(self[i], i)
      i += 1
    end
    result
 end

  def my_select
    result = []
    my_each { |item| result << item if yield item }
    result
  end

  def my_all?
    my_each { |item| return false unless yield item }
    true
  end

  def my_any?
    my_each { |item| return true if yield item }
    false
  end

  def my_none
    my_each { |item| return false if yield item }
    true
  end

  def my_count(arg = nil)
    count = 0
    my_each { |item| count += 1 if yield item } if block_given? && arg.nil?
    my_each { |item| count += 1 if arg == item } if !block_given? && !arg.nil?
    my_each { |_item| count += 1 } if !block_given? && arg.nil?
    count
  end

  def my_map(&block)
    result = []
    my_each { |item| result << block.call(item) }
    result
  end

  def my_inject(init = 0)
    result = init
    my_each { |item| result = yield(result, item) }
    result
  end
end
weekdays = %w[monday tuesday wednesday thursday]
weekdays.my_each { |day| puts day.upcase }
weekdays.my_each_with_index { |day, item| puts "#{item}.#{day.upcase}" }

def multiply_els(array)
  array.my_inject(1){ |prod, n| prod * n }
end

puts multiply_els([2,3,4])

puts [2,3,4].inject(0){|sum,item| sum+item}