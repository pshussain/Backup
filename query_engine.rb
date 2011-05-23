<<<<<<< HEAD
class QueryEngine
    attr_accessor :value
    def runQuery(date=Date.today)
        puts self.value
        count=0
        while (count<15)
            if date<Date.today
                startRange=0
                endRange=0
            else
                startRange=0
                endRange=5
            end
            for i in startRange..endRange
                puts date
            end
            date=date+1  
            count+=1
        end
    end
end
q=QueryEngine.new
q.value=10
q.runQuery(Date.today-10)
=======
require 'logger'
require 'date'
class QueryEngine
    QUERY_FILE="C:\\Hadoop\\QueryEngine\\queries.txt"
    RESULT_PATH="C:\\Hadoop\\query_result"
    def initialize
        @logger=Logger.new("C:\\Hadoop\\QueryEngine\\query_engine-#{Date.today}.log","daily")
    end
    
    def self.readQuery()
        sql=[]
        sql=IO.readlines(QUERY_FILE)
        sql  
    end
    
    def loadTables()
        #Load supporting tables for executing queries into Hive DB
        supportTable=[]
        
    end
    
    def executeQuery(date=Date.today)
      
        @logger.info("Date parameter is passed :: "+date.to_s)
        #Check for query file exists
        exit unless File.exists?(QUERY_FILE)
        curr_date=date ? date : Date.today
        if (date && Date.today>date)# ? 0 : Time.now.strftime("%H").to_i if date
            curr_hour=0
            oldDate=true
            temp_curr_date=date
            @logger.info("Provided date is old date")
        else
            curr_hour=Time.now.strftime("%H").to_i
            
        end
        date_changed=false
        #hour=0
        while curr_hour<24 #and Check for Hadoop service running
            puts "Current processing date is "+curr_date.to_s
            @logger.info("Current processing date is "+curr_date.to_s)
            puts "Current processing hour is "+curr_hour.to_s
            @logger.info("Current processing hour is "+curr_hour.to_s)
            
            execute(curr_date,curr_hour)
            #This condition should come last 
            if (date_changed && !oldDate)
                puts "Date changed"
                curr_date=curr_date+1
                curr_hour=Time.now.strftime("%H").to_i
                date_changed=false
                @logger.info("The date has been changed")
            end
            date_changed=true if Date.today>curr_date
            
            if (curr_hour==23 && !oldDate)
                puts "One day finished"
                curr_date=curr_date+1
                curr_hour=Time.now.strftime("%H").to_i
                curr_hour= oldDate ? curr_hour : 0
                @logger.info("The complete cycle is finished")
            end
            
            if (curr_hour==23 && oldDate)  
                curr_date=temp_curr_date+1
                temp_curr_date=temp_curr_date+1
                curr_hour=0
                puts "Date changed for old date"
                @logger.info("Date changed for old date")
            end
              
            sleep(1) 
            date_changed=false if Date.today==curr_date
            oldDate=false if Date.today==curr_date
            curr_hour+=1
        end
    end
    
    def execute(date,hour)
        queries=QueryEngine.readQuery()
        if queries.size==0
            @logger.error("execute :: There is no queries in the queries.txt file")
            return
        end
        loadTables()
        Dir.mkdir(RESULT_PATH) unless File.exists?(RESULT_PATH)
        Dir.mkdir(RESULT_PATH+"//"+date.to_s) unless File.exists?(RESULT_PATH+"//"+date.to_s)
        Dir.mkdir(RESULT_PATH+"//"+date.to_s+"//"+hour.to_s) unless File.exists?(RESULT_PATH+"//"+date.to_s+"//"+hour.to_s)
        @logger.info("List of queries :: "+queries.to_s)
        
        for sql in queries
            Thread.new do
                print sql.split("\t")[0].to_s 
                print sql.split("\t")[1].to_s
              
                @logger.info(sql)
            end
            puts  
        end
    end
end
  
QueryEngine.new.executeQuery()
#puts QueryEngine.execute
>>>>>>> 21b9757621d7597ab715e1f32abd2839d039174a
