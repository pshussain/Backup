require 'rubygems'
require 'uri'
#~ require 'fastercsv'
class LogCrawler
  
      MYSQL_LOG_PATH="www-slow.log"
      NGINX_LOG_PATH="nginx_error.log"
      MONGREL_LOG_PATH=""
  
      def initialize
      end
      #Parse Nginx Log file and create csv file
      #Store Nginx log file data into database table every day
      #Delete Nginx log data from databases for every two days
      
      def nginx
          file = File.new(NGINX_LOG_PATH, "r")
          #~ linesArray = Array.new
          dataHash = Hash.new
          #~ dataHash={"nginx"=>{server_ip=>{port=>{"url_path"=>"","click"=>0}}}}
          #~ csvstr = FasterCSV.generate do |csv|
          #~ csv << ["Server Ip", "Port", "Request From", "Client Id", "Ad Id", "Impressions", "Clicks", "Request URL"]
          while (line = file.gets)
              begin
                  url = ((line.split("upstream:")[1]).split(", host:")[0]).gsub('"','').strip
                  server_ip = ((url.split("http://")[1]).split("/")[0]).split(":")[0]
                  port = ((url.split("http://")[1]).split("/")[0]).split(":")[1]
                  url_path = ((url.split("http://")[1]).split("/")[1]).split("?")[0]
                  clicks = impressions = 0
                  if (url_path=="waplanding") 
                      clicks=1
                      url_param = url.split("lm=")[1]
                      cid = url_param.split("%7C")[0]
                      ad_id = (url_param.split("-")[1]).split("~")[0]
                  elsif (url_path=="static_ad")
                      impressions=5
                      url_param = (url.split("id=")[1]).split("&")[0]
                      cid = url_param
                  else
                      impressions=1
                      url_param = (url.split("cid=")[1]).split("&")[0]
                      cid = url_param
                      ad_id = 0
                  end
                
                  #~ value = {"server_ip"=>server_ip,"port"=>port,"url_path"=>url_path,"click"=>click,"impression"=>impression,"cid"=>cid,"ad_id"=>ad_id}
                  if dataHash[server_ip.to_s+port.to_s]!=nil
                      #~ p dataHash[server_ip.to_s+port.to_s]["nginx"][server_ip][port.to_s]["clicks"]+=clicks
                      #~ dataHash[server_ip.to_s+port.to_s]["nginx"][server_ip][port.to_s]["impressions"]+=impressions
                      dataHash[server_ip.to_s+port.to_s]={"nginx"=>{server_ip=>{port.to_s=>{"cid"=>cid,"url_path"=>url_path,"clicks"=>dataHash[server_ip.to_s+port.to_s]["nginx"][server_ip][port.to_s]["clicks"]+=clicks,"impressions"=>dataHash[server_ip.to_s+port.to_s]["nginx"][server_ip][port.to_s]["impressions"]+=impressions}}}}
                      #~ dataHash[server_ip.to_s+port.to_s]
                  else
                      dataHash[server_ip.to_s+port.to_s]={"nginx"=>{server_ip=>{port.to_s=>{"cid"=>cid,"url_path"=>url_path,"clicks"=>clicks,"impressions"=>impressions}}}}
                  end
                  
                  #~ dataHash.store("nginx",{server_ip=>{}})
                  #~ csv << [server_ip, port, url_path, cid, ad_id, impression, click, url]
                  server_ip = port = url_path = cid = ad_id = impression = click = url = url_param = nil
              rescue Exception => e
                  puts e
              ensure
                  dataHash.each_value{|k,v|  p k}
              end
          end
      end
      
      #Read mysql slow query log files
      #Have all mysql server details in variable
      #Read all the mysql server slow query log file sizes
      #Compare the current file size and previously read log file size
      #If the sizes are varying too much then update the status in Database table
      #as slow query log is increasing by 
      #If the size is not increased too much update the status in Database table
      #as slow query log is stable
      def mysql
        
          fileSize=File.stat(MYSQL_LOG_PATH).size 
          range=0
          
          while true
              if File.stat(MYSQL_LOG_PATH).size>fileSize.to_i
                  range=(File.stat(MYSQL_LOG_PATH).size.to_f/fileSize.to_f).to_f unless fileSize==0
                  puts "File size is increased by #{range ? range : fileSize}"
                  
                  fileSize=File.stat(MYSQL_LOG_PATH).size
                  if range.to_f>0.5
                      #update database with warning messsage
                      puts "update database with warning messsage"
                  else
                      #update database with info message
                      puts "update database with info message"
                  end
                  range=0.0
              else
                  puts "File size is stable"
              end
              sleep(5)
          end
      end

      #Read mongrel log files
      #Have all mongrel server and port details
      #Read all the mongrel log file sizes
      #Compare the current file size and previously read log file size
      #If the sizes are varying 0.5 percent then update the status in Database table
      #as mongrel log is increasing by 0.5 percent
      #If the size is not increased too much update the status in Database table
      #as mongrel log is stable
      def mongrel
          
          fileSize=File.stat(MONGREL_LOG_PATH).size 
          range=0
          while true
              if File.stat(MONGREL_LOG_PATH).size>fileSize.to_i
                  range=(File.stat(MONGREL_LOG_PATH).size.to_f/fileSize.to_f).to_f unless fileSize==0
                  puts "File size is increased by #{range ? range : fileSize}"
                  
                  fileSize=File.stat(MONGREL_LOG_PATH).size
                  if range.to_f>0.5
                      #update database with warning messsage
                      puts "update database with warning messsage"
                  else
                      #update database with info message
                      puts "update database with info message"
                  end
                  range=0.0
              else
                  puts "File size is stable"
              end
              sleep(5)
          end
      end
end
#~ end
#~ file.close
#~ file=File.new("nginx_error_log_#{Time.now.strftime('%Y_%B_%d')}" + ".csv","w+")                 
#~ file.write(csvstr)!=nil
#~ file.close()  
#~ puts dataHash["192.168.1.207104"]["nginx"]["192.168.1.20"]["7104"].inspect



lc=LogCrawler.new
methodArray=ARGV[0].split(",")if ARGV[0]
for method in methodArray
    Thread.new do
        lc.send(method.to_sym) if method
    end
end



