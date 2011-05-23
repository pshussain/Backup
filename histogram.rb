class Hash
        define_method('histogram') do
            res=count(self.values)
            
        end
        define_method('sort') do |result|
            result.sort{|x,y|  y[1] <=> x[1]}
        end  
          
        def count(values)
            all_values=values
            compact_values=values.uniq
            result=[]
            values=nil
            counter=0
            compact_values.each{|v|
                counter=0
                all_values.collect{|val|
                    if val==v
                        counter=counter+1
                    end
                }
                 result<<[v,counter]
            }
            return sort(result)         
        end
  end
  
  
h={:k1 => 'a', :k2 => 'b', :k3 => 'b', :k4 => 'c', :k5 => 'b', :k6 => 'b', :k7 => 'a',:x=>'a'}
 puts h.histogram
   
   

