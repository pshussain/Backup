class NumericArray
   
  def avgArray(arr)
   
    temp=0.0
    for i in 0...arr.length
      temp=temp+Integer(arr[i])
      
    end
    puts temp/arr.length
  end
end

obj=NumericArray.new

obj.avgArray(["10",2,3,4])
obj.avgArray(["10",2,'20',4])

