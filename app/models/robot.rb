class Robot

  attr_reader :id,
              :name,
              :city,
              :state,
              :avatar_location,
              :birthday,
              :hire_date,
              :department

  def initialize(data)
    @id = data["id"]
    @name = data["name"]
    @city = data["city"]
    @state = data["state"]
    @avatar_location = data["avatar"]
    @birthday = data["birthday"]
    @hire_date = data["hire_date"]
    @department = data["department"]
  end

end
