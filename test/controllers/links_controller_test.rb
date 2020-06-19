# frozen_string_literal: true

require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    host! ENV['HOST']
  end

  test 'should get show' do
    get root_path
    assert_response :success
  end

  test 'should get show with url' do
    get root_path(url: 'https://speedcurve.com/') # Note: Has `/` as `location` in header, used to cause infinite loop
    assert_response :success

    get root_path(url: 'http://google.com/')
    assert_response :success

    get root_path(url: 'https://click.linksynergy.com/deeplink?id=nOD%2FrLJHOac&mid=24542&u1=verge&murl=https%3A%2F%2Fwww.microsoft.com%2Fstore%2Fr%2F9NBNGW0R7KVH')
    assert_response :success
  end
end
