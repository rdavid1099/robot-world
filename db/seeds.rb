require 'sqlite3'

database = SQLite3::Database.new("db/robot_world_development.db")

database.execute("DELETE FROM robots")

database.execute("INSERT INTO robots
  (id, name, city, state, avatar, birthday, hire_date, department)
  VALUES
  ('123', 'Bob', 'Den', 'CO', 'https://robohash.org/bob', '1990-01-01', '2016-08-21', 'fun');"
)

puts "It worked and:"
p database.execute("SELECT * FROM robots;")
