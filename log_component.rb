require 'rubygems'
require 'uri'
#~ require 'fastercsv'
class LogCrawler
      #Parse Nginx Log file and create csv file
      #Store Nginx log file data into database table every day
      #Delete Nginx log data from databases for every two days
      
      def nginx
          file = File.new("nginx_error.log", "r")
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
      #as slow query log is increasing
      #If the size is not increased too much update the status in Database table
      #as slow query log is fine
      def mysql
          for i in 0..3
              p File.stat("www-slow.log").size
              p File.stat("www-slow-1.log").size
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
lc.nginx



