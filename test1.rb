class Integer
  
  
  define_method('generate') do
    value = ""; 
    self.times{value  << (45 + rand(50)).chr}
    puts value
  end
end
5.generate
