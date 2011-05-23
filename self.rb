    class WhatIsSelf  
      def test  
        puts "At the instance level, self is #{self}"  
      end  
      def self.test  
        puts "At the class level, self is #{self}"  
      end  
    end  
    WhatIsSelf.test   
    #=> At the class level, self is WhatIsSelf  
   WhatIsSelf.new.test   
    #=> At the instance level, self is #<WhatIsSelf:0x28190>  