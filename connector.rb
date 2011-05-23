require 'net/http'
require 'uri'
require 'open-uri'
class Connector
  def initialize
      @urls=Hash.new
      @params=Hash.new
      @responseKey=Hash.new
      @resType=Hash.new
  end
  
  def setUrl(cid,url)
      @urls.store(cid,url)
      
  end
  
  def getUrl(cid)
      @urls[cid]
  end
  
  def setParams(cid,params)
      paramsArray=[]
      for i in 0...params.size
          paramsArray<<params[i]
      end
      @params.store(cid,paramsArray)
      
  end
  
  def getParams(cid)
      @params[cid]
  end
  
  def setResType(cid)
      @resType.store(cid,"text")
  end
   
  def getResType(cid)
      @resType[cid]
  end
  
  def setResponse(cid)
  end
   
  def getResponse(cid)
  end
  
  def makeURL(cid,values)
      #http://adserver20.zestadz.com/waphandler/deliverad?ua=Nokia5300/2.0%20(05.51)%20Profile/MIDP-2.0%20Configuration/CLDC-1.1&ip=47.152.205.255&cid=14131C047A50414347574B574153415E8C&fcid=14131C047A50414347574B574153415E8C&meta=pepsi&keyword=All
      # All parameter names coming from database 
      params=getParams(cid)
      #All query parameter values are coming from user input
      
      queryString=''
      for i in 0...params.size
          queryString=queryString+params[i]+'='+values[i]
          queryString=queryString+'&' if i<params.size-1
      end
      #puts queryString  
      url=getUrl(cid)#?ua=Nokia5300/2.0%20%2805.51%29%20Profile/MIDP-2.0%20Configuration/CLDC-1.1&ip=196.207.40.25&cid=14131C047A50414347574B574153415E8C&fcid=14131C047A50414347574B574153415E8C&meta=pepsi&keyword=All'
      url=url+'?'+queryString
      puts url
      postURL(url)
  end
  def postURL(url)
      Net::HTTP.get_print URI.parse(url)
  end
end


c=Connector.new
#c.makeURL
c.setUrl(100,'http://ad.yieldmanager.com/st')
puts c.getUrl(100)
params=['ad_type','ad_size','section','pub_redirect_unencoded','pub_redirect']
c.setParams(100,params)
puts c.getParams(100)
values=['Nokia5300/2.0%20%2805.51%29%20Profile/MIDP-2.0%20Configuration/CLDC-1.1','196.207.40.25','14131C047A50414347574B574153415E8C','14131C047A50414347574B574153415E8C','pepsi','All']

values=['ad','300x50','1204579','1','ENTER_CLICK-TRACKING-URL_HERE']
c.makeURL(100,values)

#http://ad.yieldmanager.com/st?ad_type=ad&ad_size=300x50&section=1204579&pub_redirect_unencoded=1&pub_redirect=ENTER_CLICK-TRACKING-URL_HERE