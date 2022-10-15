class Array

    def my_each(&prc)
        i =0
        until i == self.length
            prc.call(self[i])
            i+=1
        end
        return self
    end

    def my_select(&prc)
        arr = []
        self.my_each do |ele|
            if prc.call(ele)
                arr << ele
            end
        end
        return arr
    end

    def my_reject(&prc)
        arr = []
        self.each do |ele|
            if !prc.call(ele)
                arr << ele
            end
        end
        return arr
    end

    def my_any?(&prc)
        arr = []
        self.my_each do |ele|
            if prc.call(ele)
                arr << ele
            end
        end
        arr.length >= 1
    end

    def my_all?(&prc)
        arr = []
        self.my_each do |ele|
            if prc.call(ele)
                arr << ele
            end
        end
        arr.length == self.length
    end

    def my_flatten
        self.inject([]) do |acc, el|
            if el.instance_of?(Array)
                acc += el.my_flatten
            else
                acc <<  el
            end
        end
    end


    def my_zip(*arr)
        arr2 = []
        arr3 = []
        self.each_with_index do |ele, i|
            arr2 = [ele]
            arr.each {|el| arr2 << el[i] }
            arr3 << arr2
        end
        arr3
    end

    def my_rotate(n = 1)
        arr = self.map{|ele| ele}

            if n > 0
                n.times do
                    k = arr.shift
                    return arr.push(k)
                end
            else
                (n * -1).times do
                    k = arr.pop
                    arr.unshift(k)
                end
            end

        return arr
    end

    def my_join(char='')
        str = ''
        self.my_each do |ele|
            str += ele + char
        end
        str
    end

    def my_reverse
        arr = []
        (0...self.length).to_a.my_each do |ele|
            arr << self[self.length-1-ele]
        end
        arr
    end


end


# calls my_each twice on the array, printing all the numbers twice.
return_value = [1, 2, 3].my_each do |num|
    puts num
   end.my_each do |num|
    puts num
   end
   # => 1
    #    2
    #    3
    #    1
    #    2
    #    3

   p return_value  # => [1, 2, 3]

puts
a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []

puts
a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

puts
a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true


puts
p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

puts
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

puts
a = [ "a", "b", "c", "d" ]
#p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]


puts
a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"


puts
p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
