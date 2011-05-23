<<<<<<< HEAD
require 'socket'      # Sockets are in standard library

hostname = 'localhost'
port = 8000

s = TCPSocket.open(hostname, port)

while line = s.gets   # Read lines from the socket
  puts line.chop      # And print with platform line terminator
end
s.close
=======
require 'net/http'

for i in 0...1
  for j in 0..10
  Thread.new do
      h = Net::HTTP.new("localhost", 9500)
      res=h.get("/")
      puts res.body
      print i.to_s+"-"+j.to_s
      
  end
  end
end


for i in 0...1
  for j in 0..10
  Thread.new do
      h = Net::HTTP.new("localhost", 9500)
      res=h.get("/")
      puts res.body
      print i.to_s+"-"+j.to_s
      
  end
  end
end
>>>>>>> 21b9757621d7597ab715e1f32abd2839d039174a
