require 'yaml'
require 'find'
require 'fileutils'
require 'ftools'
require 'map_reduce.rb'
class WorkerBalancer
    CONFIG_FILE="C:\\RubySamples\\worker_manager.yml" 
    include MapReduce
    def initialize
        worker={:root_dir=>'C:\\Users\\Hussain\\Unprocessed',:ip=>'192.168.1.107',:date=>Time.now.to_s,:file_type=>["jpg"],:status=>"STOPPED",:start_time=>Time.now,:end_time=>nil}
        config={:worker=>worker}
        File.open(CONFIG_FILE, 'w' ) do |out|
            YAML.dump( config, out )
        end
    end
    def processFiles
        config = open(CONFIG_FILE) {|f| YAML.load(f)}
        config[:worker][:status]="RUNNING"
        File.open(CONFIG_FILE, 'w' ) do |out|
            YAML.dump( config, out )
        end
        fileArray=[]
        totalFiles=0
        begin
            Find.find(config[:worker][:root_dir].to_s) do |path|
                if FileTest.directory?(path)
                    next
                else #we have a file
                    filetype = File.basename(path.downcase).split(".").last
                    if config[:worker][:file_type].include?(filetype)
                        #File.copy(path,PROCESSING_DIR)
                        totalFiles = totalFiles + 1
                        fileArray << path
                    end
                end
            end
            #~ puts totalFiles
            distributeWorker(fileArray,totalFiles)
            config[:worker][:end_time]=Time.now.to_s
            config[:worker][:status]="DONE"
        rescue Exception=>e
            config[:worker][:end_time]=Time.now.to_s
            config[:worker][:status]="FAILED"
        end  
        File.open(CONFIG_FILE, 'w' ) do |out|
            YAML.dump( config, out )
        end
    end
    def distributeWorker(fileArray,totalFiles)
        #puts files.size
        #Find no of worker and array of file names using algorithm
        #Start worker process to move the files from unprocessed to processed directory
        #Call worker program with array of file names
        rangeArray=divideWorker(totalFiles)
        for i in 0...rangeArray.size
            if rangeArray.size-1!=i
                puts low=rangeArray[i] 
                puts high=rangeArray[i+1]
                puts tempArray=fileArray[low..high]
            else
                  puts "Else"
                  puts low=rangeArray[i]
                  puts tempArray=fileArray[low]
            end
            
            #~ puts rangeArray[i+1]
        end
        
    end
end
wm=WorkerBalancer.new
wm.processFiles
