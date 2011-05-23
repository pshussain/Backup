require 'drb'
class HashPool
  attr_reader :port
  
  def initialize
      puts "This is initialize"
      @@drbObj=Hash.new
      @@port=nil
      for i in 0...3
          @@drbObj.store('900'+i.to_s,DRbObject.new(nil, 'druby://localhost:900'+i.to_s))
     end
  end
  def HashPool.getPort
    @@port
  end
  def setPort
    
    begin
        portRequest=Hash.new
        @@drbObj.each_pair {|port,obj|
        portRequest.store(port,obj.port)
        }
        @@port=portRequest.index(portRequest.values.min)
     rescue Exception=>e
        puts "Error in setsPort :: #{e.message}"
     end
     
      #puts @@port
  end
  
end
HashPool.new.setPort
#h.setPort


puts HashPool.getPort

