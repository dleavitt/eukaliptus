module Eukaliptus
  module FacebookHelpers
    
    def fb_init(options = {})
      locale = options.delete(:locale) || "en_US"
      callback = options.delete(:callback)
      
      defaults = { 
        :app_id => Facebook::APP_ID.to_s,
        :status => true,
        :cookie => true,
        :xfbml => true,
        :oauth => true, 
        # TODO: channelURL middleware
        :channel_url => "#{root_url}channel.html", 
      }
      
      options.reverse_merge!(defaults).keys.each do |key|
        options[key.to_s.camelize(:lower)] = options.delete(key)
      end
      
      template = Erubis::Eruby.new File.new(File.dirname(__FILE__) + "/../templates/fb_init.erb").read
      js = template.result  :locale => locale, 
                            :options => options, 
                            :callback => callback
      
      js.html_safe
    end
    
    def like_button(data_opts = {}, opts = {})
      data_opts.to_options!.reverse_merge!({
        href:             url_for(only_path: false),
        send:             true,
        layout:           'button_count',
        width:            115,
        :'show-faces' =>  false,
        font:             'arial',
      })

      opts.to_options!.reverse_merge!({
        class: 'fb-like',
      })
      data_opts.each { |key,val| opts["data-#{key}"] = val }

      content_tag :div, '', opts 
    end
    
    def fb_photo_url(id, type="square")
      "https://graph.facebook.com/#{id}/picture?type=#{type}"
    end
    
  end
end