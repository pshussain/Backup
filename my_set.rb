require 'rubygems'
require 'set'
class MySet
  def initialize(*args)
      @data=args
      #~ puts @data
  end
  def average
      @data.inject{ |sum, el| sum + el }.to_f / @data.size
  end
def median#(array, already_sorted=false)
return nil if @data.empty?
@data = @data.sort unless false
m_pos = @data.size / 2
@data.size % 2 == 1 ? @data[m_pos] : mean(@data[m_pos-1..m_pos])
end

def mean(array)
    array.inject(0) {|sum,x| sum+=x} / array.size.to_f
end
  def partition(val)
      @data.each_cons(val).to_a
  end
end
p MySet.new(1, 2, 3, 4, 5).median

p MySet.new(1, 2, 3, 4, 5).partition(2)

#~ p MySet.new.median([1,2,3,4,5])

