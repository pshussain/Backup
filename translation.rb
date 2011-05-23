
class String
  
  define_method("pig_latin") do
      result=[]
      temp=self.split(" ")
      for i in 0...temp.length
          if temp[i].length>1
              firstChar=temp[i].split(//)
              result<<temp[i].slice(1,temp[i].length).concat(firstChar[0]).concat("ay")
          else
              result<<temp[i]
          end
      end
      return result  
  end

end
puts ("This is a test").pig_latin