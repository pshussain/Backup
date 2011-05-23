require 'drb'


class TestServer
  attr_reader :port,:request,:status
  @@request=0
  @@status=false
  def doit
      1.upto(1000){|i|
      if i==100 or i==200 or i==300 or i=400 or i==500
          @@status=true
      end
      puts "Hello, Distributed World"
      }
      @@request=@@request+1
      doit
  end
  def port
      @@request
  end
  def status
      @@status
  end
end
port=gets
aServerObject = TestServer.new
t=Thread.new do
  aServerObject.doit
end
DRb.start_service('druby://localhost:'+port.to_s, aServerObject)
DRb.thread.join # Don't exit just yet!
