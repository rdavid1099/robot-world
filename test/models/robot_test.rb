require_relative "../test_helper"

class TestRobot < Minitest::Test
  def test_robot_knows_its_information
    data ={
          "id"         => 1,
          "name"       => "Test",
          "city"       => "city",
          "state"      => "state",
          "avatar"     => "avatar",
          "birthday"   => "1200-01-01",
          "hire_date"  => "1111-11-11",
          "department" => "dept"
          }
    bot = Robot.new(data)

    assert_equal 1, bot.id
    assert_equal "Test", bot.name
    assert_equal "city", bot.city
    assert_equal "state", bot.state
    assert_equal "avatar", bot.avatar_location
    assert_equal "1200-01-01", bot.birthday
    assert_equal "1111-11-11", bot.hire_date
    assert_equal "dept", bot.department
  end

end
