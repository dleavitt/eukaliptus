module Eukaliptus
  class Middleware
    def initialize(app, options = {})
      @app, @options = app, options
    end

    def call(env)
      @request = Request.new(env)
      # Catch and convert POST from facebook
      if @request.facebook?
        env["facebook.original_method"] = env["REQUEST_METHOD"]
        env["REQUEST_METHOD"] = 'GET'
      end

      status, headers, body = @app.call(env)
      @response = Rack::Response.new body, status, headers

      # Fixes IE security bug
      @response.header["P3P"] = 'CP="HONK HONK! http://graeme.per.ly/p3p-policies-are-a-joke"'
      
      # Serve /channel.html
      if env['PATH_INFO'] == '/channel.html'
        @response.headers['Content-Type'] = 'text/html'
        @response.body = ["<script src='http#{'s' if @request.ssl?}://connect.facebook.net/en_US/all.js'></script>"]
      end
      p @response
      @response.finish
    end
  end
end