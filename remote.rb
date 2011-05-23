require 'rubygems'
require 'net/ssh'
  require 'net/scp'

  Net::SSH.start("192.168.1.107", "root", :password => "mobile") do |ssh|
    ssh.scp.download! "//HadoopComponent//scripts//pro.txt", "F:\\Hadoop\\Ruby"
  end
