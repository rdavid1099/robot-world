require_relative "../test_helper"

class TestRobot < Minitest::Test
  include TestHelpers

  def test_it_can_add_robots
    data ={
          :name       => "Test",
          :city       => "city",
          :state      => "state",
          :month      => "01",
          :day        => "01",
          :year       => "1200",
          :department => "dept"
          }
    robot_world.add_robot(data)

    assert_equal 1, robot_world.all.length
  end

  def test_it_can_find_robots_using_id
    data ={
          :name       => "Test",
          :city       => "city",
          :state      => "state",
          :month      => "01",
          :day        => "01",
          :year       => "1200",
          :department => "dept"
          }
    robot_world.add_robot(data)
    expected = robot_world.all.first.id
    actual = robot_world.find_robot(expected)
    assert_equal expected, actual.id
  end

  def test_it_can_add_more_than_one_robot
    data ={
          :name       => "Test",
          :city       => "city",
          :state      => "state",
          :month      => "01",
          :day        => "01",
          :year       => "1200",
          :department => "dept"
          }
    robot_world.add_robot(data)
    robot_world.add_robot(data)

    assert_equal 2, robot_world.all.length
  end

  def test_it_can_change_robo_info
    data ={
          :name       => "Test",
          :city       => "city",
          :state      => "state",
          :month      => "01",
          :day        => "01",
          :year       => "1200",
          :department => "dept"
          }
    diff_data = {
          :name       => "TestING",
          :city       => "city",
          :state      => "state",
          :month      => "01",
          :day        => "01",
          :year       => "1200",
          :department => "dept"
          }
    robot_world.add_robot(data)
    robo_id = robot_world.all.first.id

    assert_equal "Test", robot_world.find_robot(robo_id).name

    robot_world.change_robot_information(robo_id, diff_data)

    assert_equal "TestING", robot_world.find_robot(robo_id).name
  end

  def test_a_robot_can_be_terminated
    data ={
          :name       => "Test",
          :city       => "city",
          :state      => "state",
          :month      => "01",
          :day        => "01",
          :year       => "1200",
          :department => "dept"
          }
    robot_world.add_robot(data)
    robot_world.add_robot(data)

    robo1 = robot_world.all.first
    robo2 = robot_world.all.last

    assert_equal 2, robot_world.all.length
    assert_equal robo1.id, robot_world.all.first.id

    robot_world.terminate_robot(robo1.id)

    assert_equal 1, robot_world.all.length
    assert_equal robo2.id, robot_world.all.first.id
  end

  def test_it_generates_unique_id_numbers_for_robots
    assert_kind_of Integer, robot_world.generate_id_number(3)
    assert_equal true, robot_world.generate_id_number(3) < 1000
    assert_equal true, robot_world.generate_id_number(3) > 99
  end

  def test_it_changes_birthday_into_standard_format
    assert_equal "2016-04-08", robot_world.generate_birthday(["08","04","2016"])
  end

  def test_it_generates_an_avatar
    assert_equal "https://robohash.org/blah", robot_world.generate_avatar("blah")
  end

  def test_it_validates_dates
    data1 ={
          :name       => "Test",
          :city       => "city",
          :state      => "state",
          :month      => "01",
          :day        => "01",
          :year       => "1200",
          :department => "dept"
          }
    data2 ={
          :name       => "Test",
          :city       => "city",
          :state      => "state",
          :month      => "02",
          :day        => "31",
          :year       => "1200",
          :department => "dept"
          }

    assert_equal true, robot_world.valid_date?(data1)
    assert_equal false, robot_world.valid_date?(data2)
  end

end
