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

    assert_equal '/', current_path

    click_on('All Robots')

    assert_equal '/robots', current_path
    assert page.has_content?('Test')

    click_on('Test')

    assert_equal "/robots/#{robo.id}", current_path

    click_on('Edit Information')

    assert_equal "/robots/#{robo.id}/edit", current_path

    fill_in('robo[name]', with: 'Rocker')
    click_on('Submit Changes')

    assert_equal "/robots/#{robo.id}", current_path
    assert page.has_content?("Rocker")
    assert_equal robo.id, robot_world.all.first.id
  end
end
