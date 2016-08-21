require_relative '../test_helper'

class UserCanSeeAllRobots < FeatureTest
  def test_user_can_see_all_robots
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

    visit '/'

    assert_equal '/', current_path

    click_on('All Robots')

    assert_equal '/robots', current_path

    assert page.has_content?('Test')
  end
end
