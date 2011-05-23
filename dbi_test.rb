require "dbi"

   begin
     # connect to the MySQL server
     dbh = DBI.connect("DBI:Mysql:task_test:localhost", "root", "admin")
     # get server version string and display it
     row = dbh.execute('SELECT * from locations into outfile "C://Users//Hussain//Desktop//temp.txt"')
     puts row.rows
   rescue DBI::DatabaseError => e
     puts "An error occurred"
     puts "Error code: #{e.err}"
     puts "Error message: #{e.errstr}"
   ensure
     # disconnect from server
     dbh.disconnect if dbh
   end
