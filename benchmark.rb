require 'benchmark'

str = Benchmark.measure do
  10_000_000.times do
    "test"
  end
end.total

sym = Benchmark.measure do
  10_000_000.times do
    :test
  end
end.total

puts "String: " + str.to_s
puts "Symbol: " + sym.to_s
puts

