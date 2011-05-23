require 'digest/md5'
 require "base64"

enc   = Base64.b64encode(':Mozilla/4.0(compatible;MSIE8.0;WindowsNT6.1;WOW64;Trident/4.0;GTB6.5;MRSPUTNIK2,3,0,228;MRA5.6(build03402);SLCC2;.NETCLR2.0.50727;.NETCLR3.5.30729;.NETCLR3.0.30729;MediaCenterPC6.0;ShopperReports3.0.489.0;SRS_IT_E879027EBD765B5332AB94;Seekmo11.0.175.0)',1)
puts enc.size
p Digest::MD5.hexdigest(':Mozilla/4.0(compatible;MSIE8.0;WindowsNT6.1;WOW64;Trident/4.0;GTB6.5;MRSPUTNIK2,3,0,228;MRA5.6(build03402);SLCC2;.NETCLR2.0.50727;.NETCLR3.5.30729;.NETCLR3.0.30729;MediaCenterPC6.0;ShopperReports3.0.489.0;SRS_IT_E879027EBD765B5332AB94;Seekmo11.0.175.0)')


