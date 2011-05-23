puts "hello world".object_id
puts "hello world".object_id
puts "hello world".object_id
puts "hello world".object_id
puts "hello world".object_id


puts :"hello world".object_id
puts :"hello world".object_id
puts :"hello world".object_id
puts :"hello world".object_id
puts :"hello world".object_id

puts Symbol.all_symbols.inspect

puts Symbol.all_symbols.collect{|sym| sym.to_s}.include?("new world%")