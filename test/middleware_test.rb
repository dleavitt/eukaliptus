require 'test_helper'

class MiddlewareTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    Eukaliptus::Middleware.new(lambda { |env| [200, {}, "Coolness"] })
  end
      
  def test_respond_p3p_headers
    get '/cookie_fix'
    assert_equal last_response["P3P"], 'CP="HONK HONK! http://graeme.per.ly/p3p-policies-are-a-joke"'
  end
end
