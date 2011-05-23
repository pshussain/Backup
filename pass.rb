require 'openssl'
require 'digest/sha1'
c = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
c.encrypt
# your pass is what is used to encrypt/decrypt
c.key = key = Digest::SHA1.hexdigest("yourpass")
c.iv = iv = c.random_iv
e = c.update(":Mozilla/4.0(compatible;MSIE8.0;WindowsNT6.1;WOW64;Trident/4.0;GTB6.5;MRSPUTNIK2,3,0,228;MRA5.6(build03402);SLCC2;.NETCLR2.0.50727;.NETCLR3.5.30729;.NETCLR3.0.30729;MediaCenterPC6.0;ShopperReports3.0.489.0;SRS_IT_E879027EBD765B5332AB94;Seekmo11.0.175.0)")
e << c.final
puts "encrypted: #{e}\n"
c = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
c.decrypt
c.key = key
c.iv = iv
d = c.update(e)
d << c.final
puts "decrypted: #{d}\n"
