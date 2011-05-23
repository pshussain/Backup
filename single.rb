class Single
  def Single.print()
      puts "This is Single::Print"
  end 
end

s=Single.new
Single.print
obj=Single.new
def obj.print
    puts "This is obj :: Print"
end
  
obj.print  

puts Single.singleton_methods
puts obj.singleton_methods