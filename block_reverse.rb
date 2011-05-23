class Array
  def reverse_iterate
    if block_given?
        current_index = self.size-1
        while current_index >= 0
          yield self[current_index]
          current_index -= 1
        end
    else
        print self.reverse
    end
  end
end

[2,4,6,8].reverse_iterate# { |i| print "#{i} "}

def some_crazy_method
  i=5
  puts "Before block i=#{i}"
 
  [1,2,3].each do |i|
    puts "In block i=#{i}"
  end
 
  puts "After block i=#{i}"
end

some_crazy_method

def method_with_block_as_closure(&block)
  another_method block
end
 
def another_method(variable)
  x=25
  variable.call x
end
 
method_with_block_as_closure {|i| print "I am happy block #{i}"}