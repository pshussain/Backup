require 'yaml'
require 'logger'
module Input
          
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
              Input::Process.start if ARGV[1]==nil
              Input::Process.start_processor if ARGV[1]=="process"
              Input::Process.start_worker if ARGV[1]=="worker"
              puts "This is start section"
              exit
          when "stop"
              puts "This is stop section"
              exit
          when "modify"
              
              puts "This is modify section"
              Input::Config.modify_worker(ARGV) if ARGV[1]=="worker"
              Input::Config.modify_processor(ARGV) if ARGV[1]=="processor"
              exit
          when "restart"
              puts "This is restart section"
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
end

Input::Config.modify_processor("","")
Input::Config.modify_worker("","","")
Input::Config.help