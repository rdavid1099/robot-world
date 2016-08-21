class RobotWorld
  attr_reader :database

  def initialize(data)
    @database = data
  end

  def all
    raw_robots.map do |data|
      Robot.new(data)
    end
  end

  def add_robot(robot)
    database.execute("INSERT INTO robots
      (id, name, city, state, avatar, birthday, hire_date, department)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?);",
      generate_id_number(robot[:name].length),
      robot[:name],
      robot[:city],
      robot[:state],
      generate_avatar(robot.values.join),
      generate_birthday([robot[:day], robot[:month], robot[:year]]),
      Time.now.to_s[0..9],
      robot[:department]
    )
  end

  def change_robot_information(id, robot_info)
    unless id == "666"
      database.execute("UPDATE robots SET
        name = ?,
        city = ?,
        state = ?,
        birthday = ?,
        department = ?
        WHERE id = ?;",
        robot_info[:name],
        robot_info[:city],
        robot_info[:state],
        generate_birthday([robot_info[:month], robot_info[:day], robot_info[:year]]),
        robot_info[:department],
        id
      )
    end
  end

  def terminate_robot(id)
    database.execute("DELETE FROM robots WHERE id = ?;", id)
  end

  def find_robot(id)
    robot_data = database.execute("SELECT * FROM robots WHERE id = ?;", id).first
    Robot.new(robot_data)
  end

  def generate_id_number(length_of_name)
    id_num = Array.new
    length_of_name.times do
      id_num << (rand(8) + 1).to_s
    end
    id_num.join.to_i
  end

  def generate_avatar(information)
    "https://robohash.org/#{information}"
  end

  def generate_birthday(raw_birthday)
    Time.parse(raw_birthday.join("/")).to_s[0..9]
  end

  def raw_robots
    database.execute("SELECT * FROM robots;")
  end

  def valid_date?(robot)
    Date.valid_date?(robot[:year].to_i, robot[:month].to_i, robot[:day].to_i)
  end

  def is_devil?(robot)
    robot[:year].include?("006") && robot[:month] == "6" && robot[:day] == "6"
  end

  def create_robot_devil
    database.execute("INSERT INTO robots
      (id, name, city, state, avatar, birthday, hire_date, department)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?);",
      666,
      "ROBOT DEVIL",
      "Treachery",
      "Robot Hell",
      "http://vignette4.wikia.nocookie.net/en.futurama/images/e/ea/RobotDevil.jpg/revision/latest?cb=20111024080305",
      "0000/01/01",
      Time.now.to_s[0..9],
      "Running Robot Hell"
    )
  end

  def average_age
    total_age = all.map {|robot| robot.age }.inject(:+)
    total_age / all.length
  end

  def created_this_year
    this_year = Time.now.to_s[0..3]
    all.reduce([]) do |result, robot|
      result << robot if hired_this_year?(robot)
    end
  end

  def hired_this_year?(robot)
    Time.now.to_s[0..3] == Time.parse(robot.hire_date).to_s[0..3]
  end

  def delete_all
    database.execute ("DELETE FROM robots;")
  end
end
