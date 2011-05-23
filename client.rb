require 'drb'

	# Prep DRb
	DRb.start_service
	# Fetch the shared object
	shared_data = DRbObject.new(nil,'druby://192.168.1.26:4000')

	# Add to the Hash
	#~ shared_data[:client] = 'Some data set by the client'
	#~ shared_data.each do |key, value|
	  #~ puts "#{key} => #{value}"
	#~ end
	# client => Some data set by the client
	# server => Some data set by the server
  advertiserId,campaigId,adId=1,2,3
  p shared_data.receiveFormData([advertiserId,campaigId,adId])
  p shared_data.getTextPage(advertiserId,campaigId,adId)
