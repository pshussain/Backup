file = File.new("www-slow.log", "r")

p File.stat("www-slow.log").size
p File.stat("www-slow-1.log").size

class MysqlLog
end