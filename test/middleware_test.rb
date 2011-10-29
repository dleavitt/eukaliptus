require 'test_helper'

class MiddlewareTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    Eukaliptus::Middleware.new(lambda { |env| [200, {}, "Coolness"] })
  end
      
  def test_respond_p3p_headers
    get '/channel.html'
    assert_equal last_response["P3P"], 'CP="HONK HONK! http://graeme.per.ly/p3p-policies-are-a-joke"'
  end
  
  def test_should_respond_with_string
    get '/channel.html'
    assert_instance_of String, last_response.body
    assert_equal "<script src='http://connect.facebook.net/en_US/all.js'></script>", last_response.body
  end
end
