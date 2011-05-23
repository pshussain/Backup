a = Thread.new { print "a"; sleep(10); print "b"; print "c" }
   x = Thread.new { print "x"; Thread.pass; print "y"; print "z" }
   x.join # Let x thread finish, a will be killed on exit.
y = Thread.new { 4.times { sleep 0.1; puts 'tick... ' }}
   puts "Waiting" until y.join(0.15)


class NginxConf
  
    def initialize
    end
    
    def create
        s1=Thread.new
        s2=Thread.new
        s3=Thread.new
    end
end