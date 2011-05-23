require 'benchmark'
require 'json'
 class A
  def initialize(string, number)
    @string = string
    @number = number
  end
 
  def to_s
    "In A:\n   #{@string}, #{@number}\n"
  end
 
  def to_json(*a)
    {
      "json_class"   => self.class.name,
      "data"         => {"string" => @string, "number" => @number }
    }.to_json(*a)
  end
 
  def self.json_create(o)
    new(o["data"]["string"], o["data"]["number"])
  end
end
 def benchmark_serialize(output_file)
  Benchmark.realtime do
    File.open(output_file, "w") do |file|
      (1..500000).each do |index|
        yield(file, A.new("hello world", index))
      end
    end
  end
end

def benchmark_deserialize(input_file, array, input_separator)
  $/=input_separator
  Benchmark.realtime do
    File.open(input_file, "r").each do |object|
      array << yield(object)
    end
  end
end



puts "Marshal:"
time = benchmark_serialize("C:\\development\\marshal.dat") do |file, object|
  file.print Marshal::dump(object)
  file.print "---_---"
end
puts "Time: #{time} sec"

array3 = []
puts "Marshal:"
time = benchmark_deserialize("C:\\development\\marshal.dat", array3, "---_---") do |object|
  Marshal::load(object.chomp)
end
puts "Array size: #{array3.length}"
puts "Time: #{time} sec"