require 'yaml'
require 'find'
require 'fileutils'
require 'ftools'
require 'date'
require 'logger'
class Worker
    SEARCH=1
    HALT=2
    STOP=3
    CONFIG_FILE="C:\\RubySamples\\worker.yml"    
    INPUT_DIR="C:\\Users\\Hussain\\Unprocessed"
    PROCESSING_DIR="C:\\Users\\Hussain\\Processing"
    PROCESSED_DIR="C:\\Users\\Hussain\\Processed\\"
    WORKER_LOG_DIR="C:\\Users\\Hussain\\Log\\"
    DELAY=10
    STATE=1
    FILE_TYPE=["jpg"]
    def initialize()
        @@stopped=0
        @logger=Logger.new(WORKER_LOG_DIR+"#{Date.today}.log","daily")
        worker={:root_dir=>INPUT_DIR,:ip=>'192.168.1.107',:state=>1,:delay=>10,:date=>Time.now,:file_type=>["jpg"],:log_path=>WORKER_LOG_DIR}
        config={:worker=>worker}
        if !File.exists?(CONFIG_FILE)
            File.open(CONFIG_FILE, 'w' ) do |out|
                YAML.dump( config, out )
            end
        end
        @logger.info("Configuration file is created fow worker")  
    end
    def conf
        if File.exists?(CONFIG_FILE)
            config = open(CONFIG_FILE) {|f| YAML.load(f)}
            @rootDirectory = config[:worker][:root_dir] ?  config[:worker][:root_dir] : INPUT_DIR
            @includedFileTypes = config[:worker][:file_type] ?  config[:worker][:file_type].to_a : FILE_TYPE
            @delay= config[:worker][:delay] ?  config[:worker][:delay].to_i : DELAY
            @status= config[:worker][:state] ?  config[:worker][:state].to_i : STATE
            @log_path=config[:worker][:log_path] ?  config[:worker][:log_path] : WORKER_LOG_DIR
            @status = @@stopped==STOP ? STOP : @status 
        else
            puts "Configuration file missing"
            exit
        end
    end
    def searchFiles
        while true
        conf
        begin
            if @status==SEARCH
                totalFiles = 0;
                Find.find(@rootDirectory) do |path|
                    if FileTest.directory?(path)
                        next
                    else #we have a file
                        filetype = File.basename(path.downcase).split(".").last
                        if @includedFileTypes.include?(filetype)
                            #puts path
                            #move the file to processing directory
                            File.copy(path,PROCESSING_DIR)
                            totalFiles = totalFiles + 1
                        end
                    end
                end
                puts "total files = " << totalFiles.to_s
                moveProcessed
                sleep(@delay)
              elsif @status==HALT
                puts "The Worker is halted by Processor"
                sleep(@delay)
            elsif @status==STOP
                puts "The Worker is stopped"
                break
            end
        rescue Exception=>e
            puts "Error in reading files : #{e.to_s}"
            moveProcessed
            sleep(@delay)
        end
        end  
    end
    def moveProcessed
        #scp command to copy the files to HDFS machine
        #move the copied files to Processed Directory
        totalFiles = 0;
        if !File.directory?(PROCESSED_DIR+"#{Date.today}")
            Dir.mkdir(PROCESSED_DIR+"#{Date.today}")
        end
        
        Find.find(PROCESSING_DIR) do |path|
            #puts path
            filetype = File.basename(path.downcase).split(".").last
            if @includedFileTypes.include?(filetype)
                File.move(path,PROCESSED_DIR+"#{Date.today}")
                totalFiles = totalFiles + 1
            end
        end
        puts "total files = " << totalFiles.to_s
    end
    def self.stop
        @@stopped=STOP
        puts "Worker is stopping..."
    end
end
trap("INT"){puts "Terminating: #{$$}"
    Worker.stop
    }  
Worker.new.searchFiles
