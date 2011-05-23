class Object
    def tap
        yield self
        self
    end
end
puts "hussain".reverse.tap{|o| puts "Reversed: #{o}"}.upcase

p 123.kilobytes