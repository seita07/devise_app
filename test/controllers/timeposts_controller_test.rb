require 'test_helper'

class TimepostsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get timeposts_index_url
    assert_response :success
  end

  test 'should get show' do
    get timeposts_show_url
    assert_response :success
  end

  test 'should get new' do
    get timeposts_new_url
    assert_response :success
  end
end
