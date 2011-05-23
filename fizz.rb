keys = [:one, :two, :three, :four]
values = [1, 2, 3, 4]
hash = keys.zip(values).inject({}) { |accu, pair| accu.store(*pair); accu }
puts hash.keys
puts hash.values