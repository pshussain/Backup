require 'profile'
require 'benchmark'
main_hash = {}
time = Benchmark.realtime do
  (1..10000).each do |number|
    simple_hash = {}
    simple_hash[number.to_s] = number
    main_hash = main_hash.merge!(simple_hash)
  end
end
puts "Time elapsed #{time} seconds"
puts "Main hash key count: #{main_hash.keys.length}"

array=Array.new
time = Benchmark.realtime do
  (1..1000).each do |number|
    string = "string#{number}"
    array << string
    inner_array = []
    (1..50).each do |inner_number|
      inner_array << inner_number
    end
    array << inner_array
    array = array.flatten!
  end
end
puts "Time elapsed #{time} seconds"

main_hash = {}
time = Benchmark.realtime do
  Profiler__::start_profile
  (1..10000).each do |number|
    simple_hash = {}
    simple_hash[number.to_s] = number
    main_hash = main_hash.merge(simple_hash)
  end
  Profiler__::stop_profile
  Profiler__::print_profile($stderr)
end
puts "Time elapsed #{time} seconds"
puts "Main hash key count: #{main_hash.keys.length}"