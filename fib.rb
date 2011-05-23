class Integer
    def fibonacci 
      self.times do|i|
        puts fib(i)
      end
    end
    def fib(n)
      curr = 1
      succ = 1

      n.times do |i|
        curr, succ = succ, curr + succ
      end
      return curr
    end
end
5.fibonacci
puts "==========================="
10.fibonacci

