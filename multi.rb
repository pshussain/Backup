
class  String

  define_method('multi_gsub') do |pattern|     
      str=self.split(//)
      pos=0
      temp=""
      for pos in 0...str.length
        case str[pos]
                when pattern[0][0]
                        temp<<str[pos].replace(pattern[0][1])
                when pattern[1][0]
                        temp<<str[pos].replace(pattern[1][1])
                else
                    temp<<str[pos]
        end
      end
      return temp
    end
    
end
puts "abmike #9191".multi_gsub([[/[a-z]/i,"#"],[/#/,"P"]])
