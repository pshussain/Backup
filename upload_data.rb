
require 'dbi'
class UploadData
  def initialize
    begin
     # connect to the MySQL server
     @@dbh = DBI.connect("DBI:MySql:balloons_test:localhost", "root", "admin")
     # get server version string and display it
     
   rescue DBI::DatabaseError => e
     puts "An error occurred"
     puts "Error code: #{e.err}"
     puts "Error message: #{e.errstr}"
   
   
   end
  end
  def upload_data
    
       old_date=Date.today-365
      
      for i in 0...365
        temp=@@dbh.select_one("select DATE_ADD('#{old_date}',INTERVAL #{i} DAY)")
        
        sql="insert into balloons (codeA,count,created_at,status_code) values('101',10,'#{temp}' ,'ebutuoy')"
        puts sql
        puts @@dbh.execute(sql)
        
      end
  end
end
obj=UploadData.new
obj.upload_data

