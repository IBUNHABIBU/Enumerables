module Enumerable
    def my_each
        i = 0
        while i<self.size
            yield self[i]
            i+=1
        end
    end

    def my_each_with_index
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
        my_each {|x| result<<x if yield |x|}
        result
    end

    def my_all?
        my_each{|x| return false unless yield x}
        true
    end

    def my_any?
        my_each{|x| return true if yield x}
        false
    end
end
weekdays=["monday","tuesday","wednesday","thursday"]
weekdays.my_each{|day| puts day.upcase}
weekdays.my_each_with_index{|day,x| puts "#{x}.#{day.upcase}"}

