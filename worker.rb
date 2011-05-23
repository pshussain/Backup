class Worker
    attr_accessor :counter
    def initialize
        @counter=0
    end
    #~ def counter
        #~ @counter
    #~ end
end
  w=Worker.new
  w.counter=10
  sleep(360)
  puts w.counter

  