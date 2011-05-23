
class MultiGsub
  def multi_gsub(arg)
            
      temp="Lorem Ipsum #9191"
      arg_one="Lorem Ipsum #9191"
      arg_two="Lorem Ipsum #9191"
      temp=temp.split(//)
      #puts arg_one=arg_one.split(//)
      #puts arg_two=arg_two.split(//)
      
      arg_one=arg_one.gsub(arg[0][0],arg[0][1])
      arg_two=arg_two.gsub(arg[1][0],arg[1][1])
      puts temp.to_s
      puts arg_one
      puts arg_two
      arg_two=arg_two.split(//)
      arg_one=arg_one.split(//)
      
      result=[]
      for i in 0...temp.length
        if (temp[i]==arg_one[i] and temp[i]==arg_two[i] and arg_one[i]==arg_two[i])
           result<<temp[i]
        end
        if(temp[i]!=arg_one[i] and arg_one[i]==arg_two[i])
          result<<arg_one[i]
        end
        if(temp[i]!=arg_two[i] and arg_one[i]==arg_two[i])
          result<<arg_two[i]
        end
        
        if(temp[i]==arg_two[i] and arg_one[i]!=arg_two[i] )
          result<<arg_one[i]
        end
        if(temp[i]==arg_one[i] and arg_one[i]!=arg_two[i] )
          result<<arg_two[i]
        end
        
      end
      puts result.to_s
  end
end
obj=MultiGsub.new
obj.multi_gsub([[/[a-z]/i, '#'], [/#/, 'P']])