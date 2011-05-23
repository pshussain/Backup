require 'find'
require 'fileutils'
require 'ftools'
require 'date'
module Merger
    SEARCH=1
    HALT=2
    STOP=3
    INPUT_DIR="C:\\Users\\Hussain\\Unprocessed"
    FILE_TYPE=["jpg"]
    DFS_INPUT="C:\\Users\\Hussain\\Unprocessed"
    def Merger.searchFiles
        @status=1
        @delay=5
        
        while true
        begin
            if @status==SEARCH
                totalFiles = 0;
                files=Array.new
                Find.find(INPUT_DIR) do |path|
                    if FileTest.directory?(path)
                        next
                    else #we have a file
                        filetype = File.basename(path.downcase).split(".").last
                        if FILE_TYPE.include?(filetype)
                            files << path
                            #move the file to processing directory
                            #File.copy(path,DFS_INPUT)
                            totalFiles = totalFiles + 1
                        end
                    end
                end
                  
                puts "total files = " << totalFiles.to_s
                if totalFiles>0
                    copyToHDFS(files)
                end
                sleep(@delay)
              elsif @status==HALT
                puts "The Processor is halted by Processor"
                sleep(@delay)
            elsif @status==STOP
                puts "The Processor is stopped"
                break
            end
            @status=STOP
            
            
        rescue Exception=>e
            puts "Error in reading files : #{e.to_s}"
            sleep(@delay)
        end
        end  
    end
    def Merger.copyToHDFS(files)
        puts "Copy all the files to HDFS file system"
        dest_dir="/input/#{Date.today}/#{Time.now}"
        system(HADOOP_PATH+MKDIR+dest_dir)
        #create directory in HDFS
        files.each do |file|
            #system(HADOOP_PATH+MOVE+dest_dir)
            #system("cd /home/hadoop/arun/hadoop-0.20.2;bin/hadoop dfs -mkdir #{@input_path}; bin/hadoop dfs -copyFromLocal #{Global::LOCAL_INPUT}#{file_name}.txt #{@input_path}")

            puts file
        end
          
    end
    def Merger.mergeFiles
        puts "Merge all the files in the particular directory"
        dest_dir="/input/#{Date.today}/#{Time.now}"
        system(HADOOP_PATH+MERGE+dest_dir)
    end
  end
  trap("INT"){puts "Terminating: #{$$}"
    Merger::stop
    }  

  Merger::searchFiles