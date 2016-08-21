require_relative '../test_helper'

class UserCanEditExistingRobot < FeatureTest
  def test_user_can_edit_existing_robot
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
    robo = robot_world.all.first

    visit '/'

    click_on('All Robots')

    assert_equal '/robots', current_path
    assert page.has_content?('Test')

    click_on('Test')

    assert_equal "/robots/#{robo.id}", current_path

    click_on('Delete')

    assert_equal "/robots", current_path
    assert_equal false, page.has_content?('Test')
    assert_equal 0, robot_world.all.length    
  end
end
