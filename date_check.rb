require 'date'
require 'time'
date=Date.today
curr_hour=Time.now.strftime("%H").to_i
curr_date=Date.today
last_date=curr_date-1
p (Date.today>curr_date-1 && last_date==(curr_date-1))
#~ while curr_hour<24
    #~ if Date.today>date
        #~ curr_hour=0
    #~ end
    #~ puts curr_hour+=1
    #~ sleep(5)
#~ end
  
  