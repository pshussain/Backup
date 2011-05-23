require 'hash_pool'
class Pool < HashPool
  def initialize
      puts HashPool.getPort
  end
end
Pool.new
    