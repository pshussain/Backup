require 'drb'
port=gets
DRb.start_service()
obj = DRbObject.new(nil, 'druby://localhost:'+port.to_s)
# Now use obj
p obj.port

