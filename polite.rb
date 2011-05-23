class Polite
  def initialize(delay=5 )
    @delay = delay
    @last_get = nil
  end

  def getDoc(uri)
    tdiff = Time.now.to_i - @last_get.to_i #diff in seconds
    sleep(tdiff+1) if (tdiff) < @delay  #force desired delay with fudge as sleep() may return early
    open(uri)
    @last_get = Time.now.to_i
  end
end

p=Polite.new(5)
p.getDoc('http://localhost:4000')
#p.getDoc("http://www.google.com/login")