require 'test_helper'


class FacebookHelpersTest < MiniTest::Spec

	include Eukaliptus::FacebookHelpers
	
	before do
		require 'erubis'
		require 'active_support/core_ext/string/output_safety'
	end

	it "should_return_fb_init_js" do
		assert_instance_of ActiveSupport::SafeBuffer, fb_init
	end
end