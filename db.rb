require 'mysql'

     dbh = Mysql.connect("localhost", "root", "admin", "task_test")

     #Query 1
     res = dbh.query("SELECT version FROM schema_migrations");
     puts "Number of rows returned: #{res.num_rows}"
     res.free

     