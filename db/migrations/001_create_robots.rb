require 'sqlite3'

environments = ["test", "development"]

environments.each do |environment|
  database = SQLite3::Database.new("db/robot_world_#{environment}.db")
  database.execute("CREATE TABLE robots (
    id VARCHAR(64),
    name VARCHAR(64),
    city VARCHAR(64),
    state VARCHAR(2),
    avatar VARCHAR(64),
    birthday VARCHAR(10),
    hire_date VARCHAR(10),
    department VARHCAR(24)
    );"
  )
  puts "creating tasks table for #{environment}..."
end
