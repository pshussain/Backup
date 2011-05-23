require 'drb'
	require 'drb/acl'

	# Setup the security--remember to call before DRb.start_service()
	DRb.install_acl(ACL.new(%w{ deny all
	                            allow 192.168.1.26
                              allow 192.168.1.86
	                            allow 127.0.0.1 } ) )
	# Start up DRb with a URI and a hash to share
	shared_hash = {:server => 'Some data set by the server' }
	DRb.start_service("druby://192.168.1.26:4000", shared_hash)
	puts 'Listening for connection…'
	DRb.thread.join # Wait on DRb thread to exit…
