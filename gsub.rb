class  String
  @@result=Array.new
  def multi_gsub(pattern)     
      str=self.split(//)
      @@orgString=self
      @@currPos=0
      @@change=false
      
     while(@@currPos<self.length)
          for patternCounter in 0...pattern.length
              @@change=false
             if (pattern[patternCounter][0].is_a? Regexp)
                regPattern(str[@@currPos],pattern[patternCounter],@@currPos)
                
                    
              elsif (pattern[patternCounter][0].is_a? String)
                strPattern(str[@@currPos-1],pattern[patternCounter],@@currPos)
              
              end
              if patternCounter==pattern.length-1 and !@@change
                  @@result<<str[@@currPos]
                  @@currPos=@@currPos.to_i+1 if !@@change  
              end
              
              break if @@change
          end
                
      end
      return @@result
    end
    
    
    def regPattern(str,regExp,pos)
        if (str=~regExp[0])
          @@found=true
          @@result<<regExp[1]
          @@currPos=@@currPos.to_i+1
          @@change=true
       
       end
     end
     def strPattern(str,strExp,pos)
        strLen=strExp[0].length
        if (strExp[0].to_s==@@orgString.slice(pos,strLen).to_s)
            @@found=true
            @@result<<strExp[1]
             @@currPos=(@@currPos.to_i)+strLen.to_i
            @@change=true
       
        end
        
     end
end
puts "abcdmike #9191".multi_gsub([[/[aeiou]/i,'#'],['bcd','HUSSAIN'],["m","P"],[/#/,"P"]]).to_s
puts 
puts "GO HOME!".multi_gsub([[/[GO]/i,'Home'],[/[home]/i,'is where the heart is']]).to_s