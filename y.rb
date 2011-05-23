class Y
  def a
    self.x
  end
  private
  def x
    puts "hi"
  end
end
 
Y.new.a