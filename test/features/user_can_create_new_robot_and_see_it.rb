require_relative '../test_helper'

class UserCanCreateNewRobotAndSeeIt < FeatureTest
  def test_user_can_create_new_robot_and_see_it
    visit '/'

    click_on('Add Robot')

    assert_equal '/robots/new', current_path
    assert page.has_css?('form')

    fill_in('inputName', with: 'Rocker')
    fill_in('placeOfOriginCity', with: 'Denver')
    find('#placeOfOriginState').find(:xpath, 'option[5]').select_option
    find('#creationDateMonth').find(:xpath, 'option[11]').select_option
    find('#creationDateDay').find(:xpath, 'option[1]').select_option
    fill_in('robo[year]', with: '1987')
    find('#department').find(:xpath, 'option[3]').select_option

    click_on('Hire Robot')

    assert_equal '/robots', current_path
    assert page.has_content?('Rocker')

    assert_equal "1987-01-11", robot_world.all.first.birthday
  end

end
