class MethodResult
  def get_and_index_all_objects_of_type(arg,type,method)
      arg.collect {|val| val.class==type ? val.send(method) : "nil"}
  end
end

obj=MethodResult.new
puts obj.get_and_index_all_objects_of_type(["Ruby",123,"def",456,"ghi"],String, :downcase)
puts obj.get_and_index_all_objects_of_type(["Rails",123,"def",456,"ghi"],String, :upcase)
puts obj.get_and_index_all_objects_of_type(["Ruby on Rails",123,"def","ghi"],String, :length)

