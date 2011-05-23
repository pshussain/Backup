my_proc = Proc.new {|x,y| print x,y}
my_lambda = lambda {|x,y| print x,y}
my_other_proc = proc {|x,y| print x,y}

# pass in one variable instead of 2
my_proc.call(1) #this doesn't throw an error and sets y to nil
#my_lambda.call(1) #this throws an error
my_other_proc.call(1) #this throws an e