<<<<<<< HEAD
require 'socket'                # Get sockets from stdlib

server = TCPServer.open(8000)   # Socket to listen on port 2000
loop {                          # Servers run forever
  Thread.start(server.accept) do |client|
    client.puts(Time.now.ctime) # Send the time to the client
    client.puts "Closing the connection. Bye!"
    client.close                # Disconnect from the client
  end
}
=======
require 'mongrel'
require 'socket'
port = (ARGV[0] || 80).to_i
class HandlerExample < Mongrel::HttpHandler
      def initialize
          puts "This is intialize"
      end
       def process(request, response)
          puts "This is process"
          response.start(200) do |head, out|
             head["Content-Type"] = "text/html"
             out.write Time.now
          end
       end
 end

server = TCPServer.new('127.0.0.1', port)
puts "server"
while (session = server.accept)
  Thread.new do
  puts "Request: #{session.gets} #{Time.now.usec}"
  session.print "HTTP/1.1 200/OK\r\nContent-type: text/html\r\n\r\n"
   res=HandlerExample.new
  
   puts res.process
  #Thread.new do
      session.print "<html><body><h1>#{Time.now}</h1></body></html>\r\n"
      sleep(0.3)
  #end
  session.close  
  #['TERM','INT'].each do |signal|
    trap("INT"){break}
  #end
end
end
>>>>>>> 21b9757621d7597ab715e1f32abd2839d039174a
