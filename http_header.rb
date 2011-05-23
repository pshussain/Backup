require 'rubygems'
require 'thread'
require 'time'
require 'drb'
#~ require 'fileutils'
require 'cgi'

class HttpHeader
    def initialize
        #create a queue
        @queue=Queue.new
        #@rootDir="C:\\Users\\mobileworx\\Downloads\\batra_component\\"
        @rootDir="/home/mobileworx/deployment/ZestADZ20/components/headers/"
    end
    
    def storeHeader(args)
        #Store the argument data into queue
	Thread.new do
	        begin
        	    @queue << args
	        rescue Exceptilon=>e
        	    puts "Error:: Error in storing header values into Queue :: "+e.to_s
	        end
	end
    end
    
    def wirteHeader()
        #Run this method as cron job
	#Thread.new do
        while true
            
            begin
                #get the length of the queue
                records = @queue.length
                if records > 0
                    file=File.new(@rootDir+"headers-#{Time.now.strftime("%H-%M-%S").to_s}.txt","w")
                    for i in 1..records.to_i
                        #read the data from the queue
                        value = @queue.pop
                        #Store it into TXT file one by one
                        file.print(value+"\n")
                    end
                    file.close  
                else
                    puts "No records in Queue"
                end      
                sleep(300)

            rescue Exception=>e
                puts "Error in wirteHeader method :: #{e.to_s}"
            end
        end
        #end
    end
    
end
#~ header=HttpHeader.new
#~ Live Code
#~ DRb.start_service("druby://192.168.1.32:2882", tlp)
#~ Local Code
#~ DRb.start_service("druby://192.168.1.86:4502", header)
#~ puts "Listening port :: 4502"
#~ header.wirteHeader
#~ DRb.thread.join # Wait on DRb thread to exit.  

puts CGI::unescape("Mozilla%2F5.0+%28Linux%3B+U%3B+Android+1.6%3B+fr-ch%3B+U20i+Build%2F1.1.A.0.8%29+AppleWebKit%2F528.5%2B+%28KHTML%2C+like+Gecko%29+Version%2F3.1.2+Mobile+Safari%2F525.20.1")
