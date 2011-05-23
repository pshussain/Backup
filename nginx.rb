ser=Array.new(["1.1","1.2","1.3"])

port=Array.new(['9000','5000','4000'])

no_of_port=Array.new(['2','3','4'])

test=[["1.1","1.2","1.3"],['9000','5000','4000']]


p test.transpose

@val=1
test.each do |ser1, ser2,ser3|
  p ser1.inspect
end



require 'generator'

	enumerator = SyncEnumerator.new(%w{1.1 1.2 1.1 1.2}, %w{9000 5000 9001 5001})
	enumerator.each do |row|
	  #~ row.each { |word| puts word }
	  #~ puts '---'
	end



arr=Array.new
for i in 0..ser.size
  #~ puts ser[i]+"-"+port[i].to_s+"-"+no_of_port[i].to_s
end