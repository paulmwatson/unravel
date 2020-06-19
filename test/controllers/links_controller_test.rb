# frozen_string_literal: true

require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get root_url
    assert_response :success
  end

  test 'should get show speedcurve.net' do
    get root_url(url: 'https://speedcurve.net/')
    assert_response :success
  end
end
