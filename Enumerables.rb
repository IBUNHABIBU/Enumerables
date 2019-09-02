module Enumerable
    def my_each
        i = 0
        while i<self.size
            yield self[i]
            i+=1
        end
    end

    def my_each_with_indeitem
        i = 0
        result = []
        while i < self.size
            result << yield(self[i],i)
            i +=1
        end
        result
    end

    def my_select
        result=[]
        my_each {|item| result<<item if yield item}
        result
    end

    def my_all?
        my_each{|item| return false unless yield item}
        true
    end

    def my_any?
        my_each{|item| return true if yield item}
        false
    end

    def my_none
        my_each{|item| return false if yield item}
        true
    end

    def my_count(arg=nil)
        count=0
        my_each{|item| count += 1 if yield item} if block_given? and arg.nil?
        my_each{|item| count += 1 if arg == item} if !block_given? and !arg.nil?
        my_each{|item| count += 1} if !block_given? and arg.nil?
        count
    end

    def my_map(&block)
        result = []
        my_each{|item| result<<block.call(item)}
        result
    end

    def my_inject(init=nil)
        result=0
        my_each{|item| result = yield(result,item)}
        result
    end
end
weekdays=["monday","tuesday","wednesday","thursday"]
weekdays.my_each{|day| puts day.upcase}
weekdays.my_each_with_indeitem{|day,item| puts "#{item}.#{day.upcase}"}

    def multiply_els(array)
        array.my_inject(4){|item,n| item*n}
    end
    
puts multiply_els([5, 7, 8,2])

