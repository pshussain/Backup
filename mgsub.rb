# :title:Multiple GSUB
# <b> This is makes documents bold</b>
# *bold*
#= Heading one
#== Heading Two
#=== Heading Three
class String
  def mgsub(key_value_pairs=[].freeze)
      begin
          
          regexp_fragments=key_value_pairs.collect{|k,v|k}
          
         
          self.gsub(Regexp.union(*regexp_fragments))do |match|
               

              key_value_pairs.detect{|k,v|
              
              #puts "Key is #{k.class} and Match is #{match} and Value is #{v}"
              (k.is_a? Regexp) ? k=~match : k==match}[1]
              
          end
      rescue Exception=>e
          return e.message
                 
      end  
  end
end
 puts "GO HOME! e GO".mgsub([[/GO*./i,'Home'],[/HOME/i,'is where the heart is']])
 puts "abcdmikeu| #9191".mgsub([[/[aeiou]/i,'#'],["#","P"],[/1/,"V"]]).to_s