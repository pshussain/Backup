class Hash
  def sort_values
      h={:hussain=>1,:marliya=>2,:shaheen=>3}
      
      puts h.values.sort.max
      puts h.values.sort.min
      
  end
end

h=Hash.new
h.sort_values