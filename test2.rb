
class Translation
  
  def pig_latin(str)
      
      temp=str.split(" ")
      for i in 0...temp.length
          if temp[i].length>1
              tempChar=temp[i].split(//)
              puts temp[i].slice(1,temp[i].length).concat(tempChar[0]).concat("ay")
          else
              puts temp[i]
          end
      end
  end

end

obj=Translation.new
obj.pig_latin("This is a test")