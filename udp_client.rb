require 'socket'
p sock = UDPSocket.new

data = 'I sent this'
p sock.send(data, 0, 'redhat', 33333).inspect
sock.close
