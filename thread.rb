require 'net/http'
require 'drb'
pages = %w( www.rubycentral.com
            www.awl.com
            www.pragmaticprogrammer.com
           )

threads = []

for page in pages
  threads << Thread.new(page) { |myPage|

    puts page
  }
end

DRb.thread.join

