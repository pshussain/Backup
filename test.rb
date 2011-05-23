class String
  define_method('last') do |n,M|
      puts n
      puts self
      self[-n,M]
      
end
end

puts "here is a string".last(6,5)