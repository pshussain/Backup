<<<<<<< HEAD
require 'find'
require 'ftools'
class InputProcessor
  
    def initialize(job)
        @rootDirectory ="F:\\Hadoop\\Unprocessed"
        @includedFileTypes=["txt"]
        @job=job
        @processing_dir="F:\\Hadoop\\Processing\\"
    end
    def readFiles
        totalFiles=0
        begin
            (file = File.new('shared_file','r')).flock(File::LOCK_EX)
            lines = file.readlines
            if lines != nil and lines != "" and !lines.empty?
                #puts "Read Mode"
                Dir.mkdir(@processing_dir+@job.to_s) if !File.exists?(@processing_dir+@job.to_s)
                Find.find(@rootDirectory) do |path|
                      if FileTest.directory?(path)
                          next
                      else #we have a file
                          filetype = File.basename(path.downcase).split(".").last
                          if @includedFileTypes.include?(filetype)
                              #puts path
                              #move the file to processing directory
                                File.move(path,@processing_dir+@job.to_s) if File.exists?(path)
                                totalFiles = totalFiles + 1
                          end
                      end
                end
                #puts "Total Files in Job "+ @job.to_s +" is :: "+ totalFiles.to_s
                
                puts "Total Files in Job "+@job.to_s + " is :: " + totalFiles.to_s
            end
            
        rescue Exception=>e
            puts "Error is :: " +e.to_s
            file.flock(File::LOCK_UN)
            file.close
        ensure
            file.flock(File::LOCK_UN)
            file.close
        end
    end
end
while true
    delay=ARGV[0].to_i
    ip=InputProcessor.new(delay)
    ip.readFiles
    sleep(300)
=======
require 'yaml'
require 'logger'
module Input
          CONFIG_FILE="C:\\RubySamples\\iop_conf.yml"
        INPUT_DIR="C:\\Users\\Hussain\\Unprocessed"
        WORKER_DIR="C:\\Users\\Hussain\\"
        PROCESSOR_LOG_DIR="C:\\Users\\Hussain\\Log"
        WORKER_LOG_DIR="C:\\Users\\Hussain\\Log"
    class Config
        CONFIG_FILE="C:\\RubySamples\\iop_conf.yml"
        INPUT_DIR="C:\\Users\\Hussain\\Unprocessed"
        WORKER_DIR="C:\\Users\\Hussain\\"
        PROCESSOR_LOG_DIR="C:\\Users\\Hussain\\Log"
        WORKER_LOG_DIR="C:\\Users\\Hussain\\Log"
        def self.config(args)
            if File.exists?(CONFIG_FILE)
                File.delete(CONFIG_FILE)
            end
            no_of_worker=args[1].to_i
            worker_list=args[2].split(',')
            log_level=args[3].to_i
            for i in 0...no_of_worker
                worker={:root_dir=>INPUT_DIR,:ip=>worker_list[i],:state=>1,:delay=>10,:date=>Time.now,:file_type=>["jpg"],:log_level=>log_level,:log_path=>WORKER_LOG_DIR}
                iop={:worker_dir=>WORKER_DIR,:log_path=>PROCESSOR_LOG_DIR,:workers=>{worker_list[i]=>worker}}
                if File.exists?(CONFIG_FILE)
                    config = open(CONFIG_FILE) {|f| YAML.load(f)}
                    config[:workers][worker_list[i]]=worker
                    File.open(CONFIG_FILE, 'w' ) do |out|
                        YAML.dump( config, out )
                    end
                else
                    File.open(CONFIG_FILE, 'w' ) do |out|
                        YAML.dump( iop, out )
                    end
                end  
            end
        end   
        def self.modify_processor(args)
            if File.exists?(CONFIG_FILE)
                    config = open(CONFIG_FILE) {|f| YAML.load(f)}
                    puts config.inspect
                    config[args[2].to_symdl]=args[3]
                    File.open(CONFIG_FILE, 'w' ) do |out|
                        YAML.dump( config, out )
                    end
            else
                puts "Please configure the input processor"
                exit
            end
        end
        def self.modify_worker(args)
            if File.exists?(CONFIG_FILE)
                    config = open(CONFIG_FILE) {|f| YAML.load(f)}
                    config[:workers][args[1]][args[2].to_sym]=args[3].to_i
                    File.open(CONFIG_FILE, 'w' ) do |out|
                        YAML.dump( config, out )
                    end
                    #distribute the changes in the worker information to the corresponding worker process  
            else
                puts "Please configure the input processor"
                exit
            end
            
        end
        
        def self.help
            puts "Usage: "
            puts "ruby iop_config.rb configure 5[no_of_worker] [192.168.1.107][list_worker_ip] 1,2,3[logger_mode]"
            puts "ruby iop_config.rb start"
            puts "ruby iop_config.rb start processor"
            puts "ruby iop_config.rb start worker"
            puts "ruby iop_config.rb stop"
            puts "ruby iop_config.rb stop [192.168.1.107][worker]"
            puts "ruby iop_config.rb modify [processor|worker][component] [192.168.1.107][worker] [root_dir][key] [/root/input/file/path][value]"
            puts "ruby iop_config.rb restart"
            puts "ruby iop_config.rb status"
            puts "ruby iop_config.rb help"
        end
    end
    class Process
        def self.start_processor
            puts "This is starting processor"
            
        end
        def self.start_worker
            puts "This is starting worker"
            
        end
        def self.start
            puts "This is starting all"
            start_processor
            start_worker
        end
        def self.stop  
            puts "This is stopping all"
            stop_processor
            stop_worker
            File.delete(Input::CONFIG_FILE)
        end
        def self.stop_processor
            puts "This is stopping the processor"
        end
        def self.stop_worker
            puts "Stopping worker"
        end
    end
end

args=ARGV
while true
      Input::Config.help if ARGV.length<=0 or ARGV.length>4
      exit if ARGV.length<=0 or ARGV.length>4
      
      case ARGV[0]
          when "configure"
              puts "This is configuration section"
              Input::Config.config(ARGV)
              exit
          when "start"
              puts "This is start section"
              Input::Process.start if ARGV[1]==nil
              Input::Process.start_processor if ARGV[1]=="processor"
              Input::Process.start_worker if ARGV[1]=="worker"
              exit
          when "stop"
              puts "This is stop section"
              Input::Process.stop if ARGV[1]==nil
              Input::Process.stop_processor if ARGV[1]=="processor"
              Input::Process.stop_worker if ARGV[1]=="worker"
              exit
          when "modify"
              puts "This is modify section"
              Input::Config.modify_worker(ARGV) if ARGV[1]=="worker"
              Input::Config.modify_processor(ARGV) if ARGV[1]=="processor"
              exit
          when "restart"
              puts "This is restart section"
              Input::Process.start
              exit
          when "status"
              puts "This is status section"
              exit
          when "help"
              puts "This is help section"
              exit
          else
              exit
      end
>>>>>>> 21b9757621d7597ab715e1f32abd2839d039174a
end
