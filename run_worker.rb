class RunWorker
  def RunWorker.run(worker)
      for i in 1..worker
          puts "Worker :: "+i.to_s
          Thread.new do
              system("ruby input_processor.rb "+i.to_s)
          end
      end
  end
end
worker=ARGV[0].to_i
RunWorker.run(worker) 
