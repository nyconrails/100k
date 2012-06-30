require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
require 'nokogiri'

module LoginOrgAdmin

  @selenium=nil
  
  def self.share_admin_instance
    p "Org Admin Logging In."
    @verification_errors = []
    load_xml_file = Nokogiri::XML(File.read("config.xml"))
    @load_browser = load_xml_file.xpath('//environment/browser').attribute('name').to_s
    load_url = load_xml_file.xpath('//environment/host').attribute('custom_url').to_s
    @selenium = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*#{@load_browser}",
      :url => "#{load_url}",
      :timeout_in_second => 60

    @selenium.start_new_browser_session
    @selenium.set_speed(1000)
    @selenium.window_maximize()
    @selenium.window_focus()

    load_file = Nokogiri::XML(File.read("list_admin_users.xml"))
    @admin_email = load_file.xpath('//adminusers/admin')[0].attribute('email').to_s
    load_pswd = load_file.xpath('//adminusers/admin')[0].attribute('password').to_s
    @admin_fname = load_file.xpath('//adminusers/admin')[0].attribute('first_name').to_s
    @admin_lname = load_file.xpath('//adminusers/admin')[0].attribute('last_name').to_s
    @admin_title = load_file.xpath('//adminusers/admin')[0].attribute('title').to_s
    @selenium.open "/login"
    @selenium.type "id=email", "#{@admin_email}"
    @selenium.type "id=password", "#{load_pswd}"

    @selenium.click "name=commit"
    @selenium.wait_for_page_to_load

    return @selenium, @admin_email, @admin_fname, @admin_lname, @admin_title
  end
end
