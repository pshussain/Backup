require 'time'
for i in 0..100 do
  puts i.to_s
  (file = File.new('shared_file','w')).flock(File::LOCK_EX)
  file.write("line1\\nline2")
  sleep(10)
  puts Time.now
  file.flock(File::LOCK_UN)
  file.close
end