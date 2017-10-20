# these two lines must be at start of this file to support simplecov
require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

module SessionsTestHelper
  # sign up test user
  def sign_up_as(user)
    post users_url, params: { user: { email: user.email, name: user.name, password: user.password } }
  end

  # log in a signed up user
  def log_in_as(user)
    post login_url(email: user.email, password: user.password)
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper
  include SessionsTestHelper

  # Add more helper methods to be used by all tests here...
end
