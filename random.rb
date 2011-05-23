class String
  
  
  define_method('generate') do
    value = ""; 
    Integer(self).times{value  << (45 + rand(50)).chr}
    return value
  end
end
puts "5".generate


