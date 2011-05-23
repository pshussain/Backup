class Hash
  define_method ('invert_hash') do 
      new_hash={}
      self.each do |k,v|
          if v.is_a? Array
              v.each {|x| new_hash.add_as_key_value(x,k)}
          else
              new_hash.add_as_key_value(v,k)
          end
      end
      return new_hash  
  end
  def add_as_key_value(key,value)
      if has_key?(key)
          self[key]=[value,self[key]].flatten
      else
          self[key]=value
      end
  end
end
 h = { "n" => 100, "m" => 100, "y" => 300, "d" => 200, "a" => 100} 
puts h.invert_hash