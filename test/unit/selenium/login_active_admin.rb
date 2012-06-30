require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
require 'nokogiri'

module LoginActiveAdmin

  @selenium=nil
  
  def self.browser_instance
    p "Active Admin Logging In."
    @verification_errors = []
    load_xml_file = Nokogiri::XML(File.read("config.xml"))
    load_url = load_xml_file.xpath('//environment/host').attribute('custom_url').to_s
    @load_email = load_xml_file.xpath('//environment/user').attribute('user_email').to_s
    @load_pswd = load_xml_file.xpath('//environment/user').attribute('user_pswd').to_s
    @load_browser = load_xml_file.xpath('//environment/browser').attribute('name').to_s
    @selenium = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*#{@load_browser}",
      :url => "#{load_url}",
      :timeout_in_second => 60,
      :highlight_located_element => true

    @selenium.start_new_browser_session
    @selenium.set_speed(1000)
    @selenium.window_maximize()
    @selenium.window_focus()

    @selenium.open "admin/login"
    @selenium.type "id=admin_user_email", "#{@load_email}"
    @selenium.type "id=admin_user_password", "#{@load_pswd}"
    @selenium.click "name=commit"
    @selenium.wait_for_page_to_load
    
    return @selenium
  end
end
