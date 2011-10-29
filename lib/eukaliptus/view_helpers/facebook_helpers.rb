module Eukaliptus
  module FacebookHelpers
    
    # Renders the HTML + JS that enables the app to log in to Facebook using
    # the Javascript method.
    #
    # Accepts the permissions that your application needs to work.
    # Use the second parameter to inject some JS that will be executed in fbAsyncInit.
    #
    # Use it one time in your layout header for all pages, or add it to individual templates 
    # to ask the user for different permissions depending on the context, page, etc.
    def fb_init(options = {})
      perms = (options[:perms] || %w{email publish_stream}).join(",")
      locale = options[:locale] || "en_US"

      template = Erubis::Eruby.new File.new(File.dirname(__FILE__) + "/../templates/fb_init.erb").read
      js = template.result(:perms => perms, :locale => locale)
      
      js.html_safe
    end
    
  end
end