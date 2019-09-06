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
    if !block_given?
      return false
    end
    my_each{ |item| return false unless yield item }
  end

  def my_any?
    my_each do |item|
      if block_given?
        return true if yield item
      else
        return true if item
      end
    end
    false
  end

  def my_none?
    if block_given?
      my_each { |item| return false if yield item }
    end
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
  array.my_inject(1) { |prod, n| prod * n }
end

puts multiply_els([2, 3, 4])

puts [2, 3, 4].inject(0){|sum,item| sum+item}

puts "Is  my_all? method meet the condition? : #{[2, 3, 4, 8, 34].my_all?{|item| item>4}}"

puts "Is  my_all when no block_given? method the meet condition? : #{[true, nil, 4, 8, 34].my_all?}"

puts "Is  my_any? method meet condition? : #{[2, 4, 5, 8, 12, 34].my_any?{|item| item==12}}"

puts "Is  my_any when no block_given? method meet the condition? : #{[nil, nil, true, nil, nil].my_any?}"

puts "Is  my_none? method meet the condition? :#{[2, 4, 5, 8, 34].my_none?{|item| item>91}}"

puts "Is  all? method meet the condition? :#{[2, 4, 6, 5, 34].all?{|item| item>1}}"

puts "Is  any if no block_give? method meet the condition? :#{[nil, nil, nil, nil, nil].any?}"

puts "True ,false and nil my_any? #{[false, false, true, nil].my_any?}"

puts "when [True and nill] my_any? #{[nil, true, true].my_any?}"

puts "[All nill]my_any? #{[nil, nil, nil].my_any?}"

