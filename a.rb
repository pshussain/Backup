class A
  def main_method
    method1
  end
 
  protected
  def method1
    puts "hello 1 from #{self.class}"
  end
end
 
class B < A
  def main_method
    puts "This is B"
    method1
  end
 
end
 
class C < B
  def main_method
    #puts self
    self.method1
  end
end

c=C.new.main_method

class D < A
  def main_method
    B.new.method1
  end
  private
  def test
    puts "This is Private"
  end
end
 
D.new.main_method

D.new.send(:test)

$_="Str\n"
puts "Str".chomp("tr")
puts $_

puts "Does integer == to float: #{25 == 25.0}"
puts "Does integer eql? to float: #{25.eql? 25.0}"