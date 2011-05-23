class Array
  def shuffle!
    n = size
    until n == 0
      k = rand(n) #You can see I’m doing rand(n) rather than rand(size)
      n = n – 1
      self[n], self[k] = self[k], self[n]
    end
    self
  end
end
shuffle!