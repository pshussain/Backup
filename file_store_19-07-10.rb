#require 'error_log.rb'
#require 'mailer.rb'
require 'profile'
module FileStore	
	
	#this is folder name for logging the error of this component
	LOG_FOLDER = "FileStore_log"
	#this is the logger file name to log errors
	LOG_FILE = "File_store.log"
    
	# This Method is used to get the queuedata, ip, port  from bill engine and initialize in Variables 	
	def FileStore.write_hfile(i,p,dqueue)
	   begin
		# Initializing in Variables
		# Getting the ip adress to an instance variable
		ip=i.to_s
		# Getting the port number to an instance variable
		port=p.to_s
		# Getting the current hour to an instance variable
		time=Time.now.strftime("%H")
		# Getting the current date to an instance variable
		current_date = Time.now.strftime("%d-%m-%Y") 
		# Getting the queue data to an instance variable
		queuedata=dqueue
		# Getting the ip adress
		qlength=queuedata.length                
		#  Getting the random_no
		random_no=rand.to_s
		# Calling the create_fstructure to checking and create the folder structure and storing the queue data in to file
		create_fstructure(current_date,time,port,ip,random_no,qlength,queuedata)
	   rescue Exception => e
      puts "ERROR :: filestore class :: write_hfile method :: #{e.to_s}"
		 end
	end
	
	#This Method is used to checking and create the folder structure and storing the queue data in to file 
	def FileStore.create_fstructure(curr_date,time,ip,port,random_no,qlength,queuedata)
	    begin	
        # Check the folder Unprocessing is exists 
          Dir.mkdir( "C:\\Users\\Hussain\\Unprocessing", 755 ) if !File.exists?("C:\\Users\\Hussain\\Unprocessing")
          Dir.mkdir( "C:\\Users\\\Hussain\\Unprocessing\\#{curr_date}", 755 ) if !File.exists?("C:\\Users\\Hussain\\Unprocessing\\#{curr_date}")
          Dir.mkdir( "C:\\Users\\Hussain\\Unprocessing\\#{curr_date}\\#{time}", 755 ) if !File.exists?("C:\\Users\\\Hussain\\Unprocessing\\#{curr_date}\\#{time}")
          #file=nil
          file=File.new("C:\\Users\\Hussain\\Unprocessing\\#{curr_date}\\#{time}\\#{ip}_#{port}_#{Process.pid.to_s}_#{random_no}_ads_deliveries.lock", "w") if !File.exist?("C:\\Users\\Hussain\\Unprocessing#{curr_date}\\#{time}\\#{ip}_#{port}_#{Process.pid.to_s}_#{random_no}_ads_deliveries.lock")
    				puts "Opening the locked file to write queue data."
						begin
							puts "Writing #{queuedata.pop} records of queue data to file..."
							# Get the queue data length from queue and itereate to all 
							for i in 1..qlength.to_i
								# Get the stored values from the queue in a FIFO order
							      	record = queuedata.pop
                      puts record
								# Validate the records for nil value 
								if (record.nil? || record == "")
									puts "Incoming Queue record is blank.."
								else
									# itereate to all element in the Hash and print the value is file
									record.each_key do |key|
										# Validate the element (key) value for nil value 
										if (record[key]==nil || record[key]==" " || record[key].nil?)
											# Split the element data by tab seprated and store the file
											file.print(" \t")
										else
											# Split the element data by tab seprated and store the file
											file.print("#{record[key].chomp}\t")											
										end
										# End of Validate the element (key) value for nil value 
									end
									# End of itereate to all element in the Hash and print the value is file									
									# Split the record (row) data by new line and store the file
									file.print("\n")
								end
								# End of Validate the records for nil value 
							end
							# End of  Get the queue data length from queue and itereate to all 
						rescue Exception=>e
							puts "ERROR :: filestore class :: create_fstructure method :: file writing :: #{e.to_s}"				
              File.rename("C:\\Users\\Hussain\\Unprocessing\\#{curr_date}\\#{time}\\#{ip}_#{port}_#{Process.pid.to_s}_#{random_no}_ads_deliveries.lock","C:\\Users\\Hussain\\Unprocessing\\#{curr_date}\\#{time}\\#{ip}_#{port}_#{Process.pid.to_s}_#{random_no}_ads_deliveries.txt") if File.exist?("C:\\Users\\Hussain\\Unprocessing\\#{curr_date}\\#{time}\\#{ip}_#{port}_#{Process.pid.to_s}_#{random_no}_ads_deliveries.lock")
						ensure
							file.close
							puts "File closed."
							# Unlock the file by renaming the file
							File.rename("C:\\Users\\Hussain\\Unprocessing\\#{curr_date}\\#{time}\\#{ip}_#{port}_#{Process.pid.to_s}_#{random_no}_ads_deliveries.lock","C:\\Users\\Hussain\\Unprocessing\\#{curr_date}\\#{time}\\#{ip}_#{port}_#{Process.pid.to_s}_#{random_no}_ads_deliveries.txt") if File.exist?("C:\\Users\\Hussain\\Unprocessing\\#{curr_date}\\#{time}\\#{ip}_#{port}_#{Process.pid.to_s}_#{random_no}_ads_deliveries.lock")
							puts "File unlocked."
						end
		 rescue Exception => e
        puts "ERROR :: filestore class :: create_fstructure method :: #{e.to_s}"
        File.rename("C:\\Users\\Hussain\\Unprocessing\\#{curr_date}\\#{time}\\#{ip}_#{port}_#{Process.pid.to_s}_#{random_no}_ads_deliveries.lock","C:\\Users\\Hussain\\Unprocessing\\#{curr_date}\\#{time}\\#{ip}_#{port}_#{Process.pid.to_s}_#{random_no}_ads_deliveries.txt") if File.exist?("C:\\Users\\Hussain\\Unprocessing\\#{curr_date}\\#{time}\\#{ip}_#{port}_#{Process.pid.to_s}_#{random_no}_ads_deliveries.lock")
		 end
	end
	# End of create_fstructure method 
	
	private
	
	# This encapusulated debug method will take the error message as a parameter passed and prints that.
	def FileStore.debug(e,m)
		begin
			puts "#{Time.now} :: #{self.class} :: #{m} :: #{e.to_s}"
		rescue Exception => e
		end
		e = m = nil
	end
	
	# This encapusulated log method will take the error message as a parameter passed and prints that 
	#  Will call the error log component to log the error into og file in background
	def FileStore.log(e,m)
		begin
		    msg = "#{Time.now} :: #{self.class} :: #{m} :: #{e.to_s}"
		    error = ErrorLog.new(LOG_FOLDER,LOG_FILE,msg)
		    error.log_error
		    msg = error = nil
		rescue Exception => e
		end
		msg = error = e = m = nil
	end
	
	# This encapusulated mail method will take the error message as a parameter passed and prints that.
	# Will call the mailer component and sends out the error details to the maintenace team in email.
	def FileStore.mail(e,m)		
        begin
            subject= "Error Report - from #{self.class} / #{m}."
            mailBody=""
            mailBody+="Maintenance Team,<br><br>"
            mailBody+="An error occured in class: #{self.class} / method: #{m}.<br><br>"
            mailBody+="Error Details: <br>"
            mailBody+="#{Time.now} :: #{self.class} :: #{m} :: #{e.to_s}.<br><br>"
            mailBody+="Thanks,<br><a href='http://www.zestadz.com/'>ZestADZ</a> Team<br>support@zestadz.com<br>www.zestadz.com<br>"
            body="#{mailBody}"
            Mailer.deliver_email_alert(subject,body,nil,nil,nil)
        rescue Exception => e
        end
        subject = mailBody = body = e = m = nil
	end

	# This encapusulated this_method method will return the calling method name.
	def FileStore.this_method
		caller[0][/`([^']*)'/, 1]
	end


end

# Test data  start
dqueue = Queue.new

adsdeliveries_data = Hash.new
adsdeliveries_data1 = Hash.new

adsdeliveries_data["ua"] = nil
adsdeliveries_data["ip"] = nil
adsdeliveries_data["remote_ip"] = "remote_iptest"
adsdeliveries_data["campaign_id"] = nil
adsdeliveries_data["ad_id"] = "ad_idtest"
adsdeliveries_data["metrics"] = "metricstest"
adsdeliveries_data["client_type"] = "client_typetest"
adsdeliveries_data["keywords"] = "keywordstest"
adsdeliveries_data["city_name"] = "city_nametest"
adsdeliveries_data["cid"] = "cidtest"
adsdeliveries_data["region_name"] = "region_nametest"
adsdeliveries_data["country"] = "countrytest"
adsdeliveries_data["advertiser_id"] = "advertiser_idtest"
adsdeliveries_data["publisher_id"] = "publisher_idtest"
adsdeliveries_data["continent_code"] = "continent_codetest"
adsdeliveries_data["continent_name"] = "continent_nametest"
adsdeliveries_data["country_code"] = "country_codetest"
adsdeliveries_data["region_code"] = "region_codetest"
adsdeliveries_data["channels"] = "channelstest"
adsdeliveries_data["mobile_model"] = "mobile_modeltest"
adsdeliveries_data["carrier_name"] = "carrier_nametest"
adsdeliveries_data["device_name"] = "device_nametest"
adsdeliveries_data["clientStatus"] = "clientStatustest"

adsdeliveries_data1["ua"] = "uatest1"
adsdeliveries_data1["ip"] = "iptest1"
adsdeliveries_data1["remote_ip"] = "remote_iptest1"
adsdeliveries_data1["campaign_id"] = "campaign_idtest1"
adsdeliveries_data1["ad_id"] = "ad_idtest1"
adsdeliveries_data1["metrics"] = "metricstest1"
adsdeliveries_data1["client_type"] = "client_typetest1"
adsdeliveries_data1["keywords"] = "keywordstest1"
adsdeliveries_data1["city_name"] = "city_nametest1"
adsdeliveries_data1["cid"] = "cidtes1t"
adsdeliveries_data1["region_name"] = "region_nametest1"
adsdeliveries_data1["country"] = "countrytest1"
adsdeliveries_data1["advertiser_id"] = "advertiser_idtest1"
adsdeliveries_data1["publisher_id"] = "publisher_idtest1"
adsdeliveries_data1["continent_code"] = "continent_codetest1"
adsdeliveries_data1["continent_name"] = "continent_nametest1"
adsdeliveries_data1["country_code"] = "country_codetest1"
adsdeliveries_data1["region_code"] = "region_codetest1"
adsdeliveries_data1["channels"] = "channelstest1"
adsdeliveries_data1["mobile_model"] = "mobile_modeltest1"
adsdeliveries_data1["carrier_name"] = "carrier_nametest1"
adsdeliveries_data1["device_name"] = "device_nametest1"
adsdeliveries_data1["clientStatus"] = "clientStatustest1"

dqueue << adsdeliveries_data1
dqueue << adsdeliveries_data
dqueue << adsdeliveries_data1
dqueue << adsdeliveries_data
dqueue << adsdeliveries_data
dqueue << adsdeliveries_data1
dqueue << adsdeliveries_data
dqueue << adsdeliveries_data1
dqueue<< adsdeliveries_data

# Test data  end

# Calling write_hfile method
FileStore.write_hfile("192.168.1.10","8085",dqueue)
