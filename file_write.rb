class FileWrite
    def self.genFile
        for i in 0..9
            num=rand.to_s
            f = File.new("F:\\Hadoop\\Unprocessed\\out"+num+".lock", "w")  
            f.write("1234567890") 
            f.close
            File.rename("F:\\Hadoop\\Unprocessed\\out"+num+".lock", "F:\\Hadoop\\Unprocessed\\out"+num+".txt")  
        end
  end
end
for i in 0..9
    FileWrite.genFile
end