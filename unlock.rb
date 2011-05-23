require 'time'
for i in 0..100 do
  puts i.to_s
  start_time=Time.now
  (file = File.new('shared_file','r')).flock(File::LOCK_EX)
  end_time=Time.now
  diff=end_time-start_time
  puts diff
  lines = file.readlines
  #if(lines[0]!="line1\\n")
  puts lines
    if lines != nil and lines != "" and !lines.empty?
        puts lines.inspect
        
        
        for i in 0..10
            puts "Read Mode :: Data is #{lines[0]}"
        end
    end
      
    sleep(ARGV[0].to_i)
    #exit
  #end
  file.flock(File::LOCK_UN)
  file.close
end