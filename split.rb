class Module
  def initialize
      puts "initialize"
  end
  def f(name)
    puts b = ("_" + name.to_s).to_sym
    alias_method b, name
    define_method(name) do |*args|
      @mc ||= {}
      @mc[name] ||= {}
      puts "Comes here"
      @mc[name][args] ||= self.send b, *args
      
    end
  end
  private
  def calls
      puts "This is call"
  end
end


class Test < Module
    def initialize
        puts "Test F Method 1"
    end
    def f()
        puts "Test F Method"
    end
    f("calls")
end
m=Test.new
