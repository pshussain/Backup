
  
  def multiply(val1,val2)
      return val1*val2
  end
    alias :docalc :multiply
puts multiply(10,12)
puts docalc(20,12)


words='cab'..'car'

puts words.include?("can")

words.each {|word| puts "Hello " + word}

for j in 1..5 do
     for i in 1..5 do
         print i,  " "
     end
puts
end


a=10
b=20
puts a||=b
$a=100
@a="hussain"
@@a="Marliya"
temp=gets
CON="I Love Shaheen"
puts defined? $a

puts defined? a

puts defined? @a

puts defined? @@a

puts defined? CON

puts $_