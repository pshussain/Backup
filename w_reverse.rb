class String
    def reverse_words
      self.reverse.split.map{|w| puts w.reverse}.join(' ')
    end
end
  
puts "Hi this is hussain".reverse_words  