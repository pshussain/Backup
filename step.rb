1.step(10, 2) { |i| print "#{i} #{i+1} \n"}



file = nil
begin
  file = File.open("C:\\development\\marshal.dat")
  raise
rescue
  p 'I rescue all exception and raise new ones'
rescue 
  p "This is error"
ensure
  file.close
  p 'just closed the file'
end