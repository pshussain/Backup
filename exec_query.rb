require 'yaml'
require 'logger'
require 'date'
require 'output_processor.rb'
class ExecQuery
	CONFIG_FILE="ssh_iop_conf.yml"
	def self.execQuery(date,hour)
		begin	
		logger=Logger.new("/home/mobileworx/deployment/hadoop/processor/Log/exec-query-#{Date.today}.log","daily")	
		#date = Date.today.to_s
		temp_date=date
		wap="'WAP'"
		date="'"+date.to_s+"'"
		#date="'"+'2009-03-16'+"'"
		channel="concat('%',c.channels,'%')"
		hour = hour.to_s		
		result_path="/home/mobileworx/deployment/hadoop/processor/query_result"
		
		#hive_path="/usr/lib/hive/bin/hive"
		hive_path="hive"
		exec_cmd=hive_path +" -hiveconf hive.root.logger=INFO,console -e "
                #Giving permission to execute the hive command
                #File.chmod(040777,hive_path)
		
		obj = OutputProcessor.new
		logger.info("Executing Campaign Summaries query")
		begin		
			#Campaign Summaries
			file_name=result_path+"/"+hour.to_s+"/campaigns_summarieshive#{temp_date}hive#{hour}.txt"
			sql='"select metrics , ad_client_type , sum(impressions) , sum(clicks) , sum(cost) ,sum(gross_profit) ,sum(zestadz_revenue) , device_name ,mobile_model ,count(distinct(ipaddress)) ,advertiser_id ,campaign_id ,ad_id ,continent_code,country_code,to_date(delivery_time)  from adsdeliveries where ad_client_type='+wap+' and to_date(delivery_time)='+date+' group by to_date(delivery_time), ad_id,continent_code,country_code,device_name ,mobile_model, metrics, ad_client_type, advertiser_id,campaign_id;"'

			if(system(exec_cmd+sql +'> '+ file_name ))
				if File.exists?(file_name)
					if(File.lstat(file_name).size>0)
						#obj.dbStore(file_name)
						logger.info("execQuery :: output processor is called for Campaign Summaries")
					else
						logger.warn("execQuery :: Query file has no record for Campaign Summaries")
					end
				else
					logger.warn("execQuery :: Query file is not created for Campaign Summaries")
				end
			else
				logger.error("execQuery ::  Error in executing query :: query failed for Campaign Summaries")
			end

		rescue Exception=>e
			logger.error("execQuery :: Error in executing campaign summaries query "+e.to_s)
		end
		logger.info("Executing Publisher Channels query")
		begin
			#Publisher Channels
			file_name=result_path+"/"+hour.to_s+"/pub_channelshive#{temp_date}hive#{hour}.txt"

			sql='"select  c.channels,sum(ads.impressions),(count(ads.id)-sum(impressions)-sum(clicks)), publisher_payments_id,client_id, ad_client_type,to_date(delivery_time)  from adsdeliveries ads join channel_lists c where to_date(ads.delivery_time)='+date+' and ads.channels like '+channel+' group by c.channels, publisher_payments_id, client_id, ad_client_type,to_date(delivery_time);"'
			
			if(system(exec_cmd+sql +'> '+ file_name ))
                                if File.exists?(file_name)
                                        if(File.lstat(file_name).size>0)
                                                #obj.dbStore(file_name)
						logger.info("execQuery :: output processor called for Publisher Channels")
                                        else
						logger.warn("execQuery :: Query file has no record for Publisher Channels")
                                        end
                                else
					logger.warn("execQuery :: Query file is not created for Publisher Channels")
                                end
                        else
				logger.warn("execQuery :: Error in executing query :: query failed for Publisher Channels")
                        end
		rescue Exception=>e
			logger.error("execQuery :: Error in executing Publisher Channels query :: "+e.to_s)
		end
		logger.info("Executing Advertiser Carriers query")
		begin
			#Advertiser Carriers
			file_name=result_path+"/"+hour.to_s+"/adv_carriershive#{temp_date}hive#{hour}.txt"

			sql='"select carrier_name ,count(carrier_name),advertiser_id, campaign_id, ad_id, to_date(delivery_time) from adsdeliveries where to_date(delivery_time)='+date+' and impressions=1 group by to_date(delivery_time), ad_id,carrier_name,advertiser_id,campaign_id;"'
		
			if(system(exec_cmd+sql +'> '+ file_name ))
                                if File.exists?(file_name)
                                        if(File.lstat(file_name).size>0)
                                                #obj.dbStore(file_name)
						logger.info("execQuery :: output processor called for Advertiser Carriers")
                                        else
						logger.warn("execQuery :: Query file has no record for Advertiser Carriers")
                                        end
                                else
					logger.warn("execQuery :: Query file is not created for Advertiser Carriers")
                                end
                        else
				logger.warn("execQuery :: Error in executing query :: query failed for Advertiser Carriers")
                        end

		rescue IOError=>e
			logger.error("execQuery :: IO Error block"+e.to_s)
		rescue Exception=>e
			logger.error("execQuery :: Error in executing Advertiser Carriers query :: "+e.to_s)
		end
		logger.info("Executing Adclient Summaries query")
		begin
			#Adclient Summaries
			file_name=result_path+"/"+hour.to_s+"/adclients_summarieshive#{temp_date}hive#{hour}.txt"

			sql='"select ad_client_type as ad_client_type,ad_type as ad_type,sum(impressions) as impressions,sum(clicks) as clicks,(count(id)-sum(impressions)-sum(clicks)) as fill_rate,count(distinct(ipaddress)) as requests_unique_visitors,sum(publisher_revenue) as revenue,state as adclient_name,device_name as handset,mobile_model as handset_model,user_agent,publisher_payments_id as pub_id,client_id as client_id,continent_code as continent_code,country_code as country_code,to_date(delivery_time) as delivery_date from adsdeliveries where ad_client_type='+wap+' and to_date(delivery_time)='+date+' group by to_date(delivery_time), client_id,continent_code,country_code,device_name,mobile_model,ad_client_type,ad_type,state,user_agent,publisher_payments_id;"'
		
			if(system(exec_cmd+sql +'> '+ file_name ))
                                if File.exists?(file_name)
                                        if(File.lstat(file_name).size>0)
                                                #obj.dbStore(file_name)
						logger.info("execQuery :: output processor called for Adclient Summaries")
                                        else
						logger.warn("execQuery :: Query file has no record for Adclient Summaries")
						logger.info("execQuery :: After Query file no record")
                                        end
                                else
					logger.warn("execQuery :: Query file is not created for Adclient Summaries")
                                end
                        else
				logger.warn("execQuery :: Error in executing query :: query failed for Adclient Summaries")

                        end

		rescue Exception=>e
			logger.error("execQuery :: Error in executing Adclient Summaries query :: "+e.to_s)
		end
		logger.info("Executing Advertiser Device Properties query")
		begin
			#Advertiser Device Properties
			file_name=result_path+"/"+hour.to_s+"/adv_devicespropertieshive#{temp_date}hive#{hour}.txt"

			sql='"select user_agent, count(user_agent), device_name, mobile_model, advertiser_id, campaign_id, ad_id, to_date(delivery_time) from adsdeliveries where to_date(delivery_time)='+date+' and impressions=1 group by to_date(delivery_time),ad_id,device_name,mobile_model, user_agent, advertiser_id,campaign_id;"'

			if(system(exec_cmd+sql +'> '+ file_name ))
                                if File.exists?(file_name)
                                        if(File.lstat(file_name).size>0)
                                                #obj.dbStore(file_name)
						logger.info("execQuery :: output processor called for Advertiser Device Properties")
                                        else
						logger.warn("execQuery :: Query file has no record for Advertiser Device Properties")
                                        end
                                else
					logger.warn("execQuery :: Query file is not created for Advertiser Device Properties")
                                end
                        else
				logger.warn("execQuery :: Error in executing query :: query failed for Advertiser Device Properties")
                        end

		rescue Exception=>e
			logger.error("execQuery :: Error in executing Advertiser Device Properties query :: "+e.to_s)
		end
		logger.info("Executing Publisher Urls query")
		begin
			#Publisher Urls
			file_name=result_path+"/"+hour.to_s+"/pub_urlshive#{temp_date}hive#{hour}.txt"

			sql='"select url as url,sum(impressions) as requests,(count(id)-sum(impressions)-sum(clicks)) as fill_rate, publisher_payments_id as pub_id, client_id as client_id,to_date(delivery_time) as delivery_date from adsdeliveries where to_date(delivery_time)='+date+' group by publisher_payments_id,client_id,url,to_date(delivery_time) sort by client_id,requests desc;"'

			if(system(exec_cmd+sql +'> '+ file_name ))
                                if File.exists?(file_name)
                                        if(File.lstat(file_name).size>0)
                                                #obj.dbStore(file_name)
						logger.info("execQuery :: output processor is called for Publisher Urls")
                                        else
						logger.warn("execQuery :: Query file has no record for Publisher Urls")
                                        end
                                else
					logger.warn("execQuery :: Query file is not created for Publisher Urls")
                                end
                        else
				logger.warn("execQuery :: Error in executing query :: query failed for Publisher Urls")
                        end

		rescue Exception=>e
			logger.error("execQuery :: Error in executing Publisher Urls query :: "+e.to_s)
		end
		logger.info("Executing Publisher Carriers query")
		begin
			#Publisher Carriers
			file_name=result_path+"/"+hour.to_s+"/pub_carriershive#{temp_date}hive#{hour}.txt"

			sql='"select carrier_name, sum(impressions), (count(id)-sum(impressions)-sum(clicks)), publisher_payments_id, client_id, ad_client_type, to_date(delivery_time) from adsdeliveries where to_date(delivery_time)='+date+' group by to_date(delivery_time), client_id, carrier_name, publisher_payments_id,ad_client_type;"'

			if(system(exec_cmd+sql +'> '+ file_name ))
                                if File.exists?(file_name)
                                        if(File.lstat(file_name).size>0)
						#obj.dbStore(file_name)
						logger.info("execQuery :: output processor is called for Publisher Carriers")
                                        else
						logger.warn("execQuery :: Query file has no record for Publisher Carriers")
                                        end
                                else
					logger.warn("execQuery :: Query file is not created for Publisher Carriers")
                                end
                        else
				logger.warn("execQuery :: Error in executing query :: queryu failed for Publisher Carriers")
                        end

		rescue Exception=>e
			logger.error("execQuery :: Error in executing Publisher Carriers query :: "+e.to_s)
		end
		logger.info("Executing Advertiser Summaries query")
		begin
			#Advertiser Summaries
			file_name=result_path+"/"+hour.to_s+"/advertiser_summarieshive#{temp_date}hive#{hour}.txt"

			sql='"select metrics, ad_client_type, sum(impressions), sum(clicks), sum(cost), sum(gross_profit), sum(zestadz_revenue), count(distinct(ipaddress)), advertiser_id, campaign_id, ad_id,to_date(delivery_time) from adsdeliveries where to_date(delivery_time)='+date+' group by to_date(delivery_time),ad_id,metrics,ad_client_type,advertiser_id,campaign_id;"'

			if(system(exec_cmd+sql +'> '+ file_name ))
                                if File.exists?(file_name)
                                        if(File.lstat(file_name).size>0)
                                                #obj.dbStore(file_name)
						logger.info("execQuery :: output processor is called for Advertiser Summaries")
                                        else
						logger.warn("execQuery :: Query file has no record for Advertiser Summaries")
                                        end
                                else
					logger.warn("execQuery :: Query file is not created for Advertiser Summaries")
                                end
                        else
				logger.warn("execQuery :: Error in executing query :: query faile for Advertiser Summariesd")
                        end

		rescue Exception=>e
			logger.error("execQuery :: Error in executing Advertiser Summaries query :: "+e.to_s)
		end
		logger.info("Executing Publisher Summaries query")
		begin
			#Publisher Summaries
			file_name=result_path+"/"+hour.to_s+"/publisher_summarieshive#{temp_date}hive#{hour}.txt"

			sql='"select ad_client_type,ad_type, sum(impressions), sum(clicks), (count(id)-sum(impressions)-sum(clicks)),count(distinct(ipaddress)), sum(publisher_revenue),  publisher_payments_id, client_id, to_date(delivery_time) from adsdeliveries where to_date(delivery_time)='+date+' group by to_date(delivery_time), client_id, ad_client_type, publisher_payments_id,ad_type;"'

			if(system(exec_cmd+sql +'> '+ file_name ))
                                if File.exists?(file_name)
                                        if(File.lstat(file_name).size>0)
                                                #obj.dbStore(file_name)
						logger.info("execQuery :: output processor is called for Publisher Summaries")
                                        else
						logger.warn("execQuery :: Query file has no record for Publisher Summaries")
                                        end
                                else
					logger.warn("execQuery :: Query file is not created for Publisher Summaries")
                                end
                        else
				logger.warn("execQuery :: Error in executing query :: query failed for Publisher Summaries")
                        end

		rescue Exception=>e
			logger.error("execQuery :: Error in executing Publisher Summaries query :: "+e.to_s)
		end


		logger.info("Executing ADV GeoLocation query")
                begin
                        #ADV GeoLocation 
                        file_name=result_path+"/"+hour.to_s+"/adv_geolocationshive#{temp_date}hive#{hour}.txt"

                        sql='"select sum(impressions), continent_code,country_code, advertiser_id,campaign_id, ad_id, to_date(delivery_time) from adsdeliveries where to_date(delivery_time)='+date+' group by to_date(delivery_time), ad_id,continent_code,country_code,advertiser_id,campaign_id;"'

                        if(system(exec_cmd+sql +'> '+ file_name ))
                                if File.exists?(file_name)
                                        if(File.lstat(file_name).size>0)
                                                obj.dbStore(file_name)
                                                logger.info("execQuery :: output processor is called for ADV GeoLocation")
                                        else
                                                logger.warn("execQuery :: Query file has no record for ADV GeoLocation")
                                        end
                                else
                                        logger.warn("execQuery :: Query file is not created for ADV GeoLocation")
                                end
                        else
                                logger.warn("execQuery :: Error in executing query :: query failed for ADV GeoLocation")
                        end

                rescue Exception=>e
                        logger.error("execQuery :: Error in executing ADV GeoLocation query :: "+e.to_s)
                end


		logger.info("Executing ADV Handsets query")
                begin
                        #Publisher Summaries
                        file_name=result_path+"/"+hour.to_s+"/adv_handsetshive#{temp_date}hive#{hour}.txt"

                        sql='"select sum(impressions), handset,handset_model,advertiser_id,campaign_id, ad_id, to_date(delivery_time) from adsdeliveries where to_date(delivery_time)='+date+' group by to_date(delivery_time), ad_id,handset,handset_model,advertiser_id,campaign_id;"'

                        if(system(exec_cmd+sql +'> '+ file_name ))
                                if File.exists?(file_name)
                                        if(File.lstat(file_name).size>0)
                                                obj.dbStore(file_name)
                                                logger.info("execQuery :: output processor is called for ADV Handsets")
                                        else
                                                logger.warn("execQuery :: Query file has no record for ADV Handsets")
                                        end
                                else
                                        logger.warn("execQuery :: Query file is not created for ADV Handsets")
                                end
                        else
                                logger.warn("execQuery :: Error in executing query :: query failed for ADV Handsets")
                        end

                rescue Exception=>e
                        logger.error("execQuery :: Error in executing ADV Handsets query :: "+e.to_s)
                end


		logger.info("Executing Pub Geolocations query")
                begin
                        #Pub Geolocations
                        file_name=result_path+"/"+hour.to_s+"/pub_geolocationshive#{temp_date}hive#{hour}.txt"

                        sql='"select ad_client_type, sum(impressions), cum(clicks),(count(id)-sum(impressions)-sum(clicks)) ,sum(zestadz_revenue),continent_code, country_code,publisher_payments_id,client_id, to_date(delivery_time) from adsdeliveries where to_date(delivery_time)='+date+' group by to_date(delivery_time), ad_client_type,continent_code,country_code,publisher_payments_id,client_id;"'

                        if(system(exec_cmd+sql +'> '+ file_name ))
                                if File.exists?(file_name)
                                        if(File.lstat(file_name).size>0)
                                                obj.dbStore(file_name)
                                                logger.info("execQuery :: output processor is called for Pub Geolocations")
                                        else
                                                logger.warn("execQuery :: Query file has no record for Pub Geolocations")
                                        end
                                else
                                        logger.warn("execQuery :: Query file is not created for Pub Geolocations")
                                end
                        else
                                logger.warn("execQuery :: Error in executing query :: query failed for Pub Geolocations")
                        end

                rescue Exception=>e
                        logger.error("execQuery :: Error in executing Pub Geolocations query :: "+e.to_s)
                end


		config = open(CONFIG_FILE) {|f| YAML.load(f)}
                config[:query_state]=((config[:query_state].to_i == 2) && (config[:is_query_running]==1)) ? 1 : config[:query_state].to_i
                config[:is_query_running]=0
                File.open(CONFIG_FILE, 'w' ) do |out|
                	YAML.dump( config, out )
                end

		rescue Exception=>e
			config = open(CONFIG_FILE) {|f| YAML.load(f)}
	                config[:query_state]=((config[:query_state].to_i == 2) && (config[:is_query_running]==1)) ? 1 : config[:query_state].to_i
        	        config[:is_query_running]=0
                	File.open(CONFIG_FILE, 'w' ) do |out|
                        	YAML.dump( config, out )
	                end
		ensure
			config = open(CONFIG_FILE) {|f| YAML.load(f)}
		        config[:query_state]=((config[:query_state].to_i == 2) && (config[:is_query_running]==1)) ? 1 : config[:query_state].to_i
                	config[:is_query_running]=0
	                File.open(CONFIG_FILE, 'w' ) do |out|
        	                YAML.dump( config, out )
                	end
		end
	end
end
date=ARGV[0].to_s
#puts date
hour=ARGV[1].to_i
date=Date.strptime(date, "%Y-%m-%d")
ExecQuery.execQuery(date,hour)

