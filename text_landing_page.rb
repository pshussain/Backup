require 'drb'
class TextLandingPage
    def initialize
        
        #create a queue
        @queue=Queue.new
    end
    
    def getTextPage(advertiserId,campaigId,adId)
        #read file path for "/text_landing_page/advertiserId/campaignId/adId.txt
        #return as string or redirect to the path
        [advertiserId,campaigId,adId]
    end
    
    def receiveFormData(*args)
        #Store the argument data into queue
        @queue << args
    end
    
    def storeFormData()
        
        #Run this method as cron job
        while true
            #get the length of the queue
            records = @queue.length
            #~ csvstr = FasterCSV.generate do |csv|
            #~ csv << ["Name", "Mobile No", "Location", "Ailment", "Date"]
            for i in 1..records.to_i
                #read the data from the queue
                value = @queue.pop
                #Store it into CSV file one by one
                #~ csv << [server_ip, port, url_path, cid, ad_id, impression, click, url]
                puts "This is storeFormData #{value}"
            end
            #~ file=File.new("text_landing_page_lead_#{Time.now.strftime('%Y_%B_%d')}" + ".csv","w+")                 
            #~ file.write(csvstr)!=nil
            #~ file.close()    
            sleep(10)
        end
    end
    
end
tlp=TextLandingPage.new
DRb.start_service("druby://192.168.1.26:4000", tlp)
tlp.storeFormData
puts "Listening for connection..."
DRb.thread.join # Wait on DRb thread to exit…  