require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
require 'nokogiri'
require File.dirname(__FILE__) + '/login_active_admin.rb'
include LoginActiveAdmin

class CreateOrgAdmins < Test::Unit::TestCase
  
  def setup
    @selenium = LoginActiveAdmin.browser_instance
    @verification_errors = []
    p "Super admin creating Org admins"
  end

  def test_create_org_admins
    xml_document = File.read("list_admin_users.xml")
    load_xml_file = Nokogiri::XML(xml_document)
    load_xml_file.xpath('//adminusers/admin').each do |node|
      load_email = node['email']
      load_fname = node['first_name']
      load_lname = node['last_name']
      load_title = node['title']
      load_pswd = node['password']
      @selenium.click "link=Users"
      @selenium.wait_for_page_to_load
      assert @selenium.is_text_present("Users")
      @selenium.click "link=New User"
      @selenium.wait_for_page_to_load
      assert @selenium.is_text_present("New User")
      @selenium.type "id=user_email", "#{load_email}"
      @selenium.type "id=user_first_name", "#{load_fname}"
      @selenium.type "id=user_last_name", "#{load_lname}"
      @selenium.type "id=user_title", "#{load_title}"
      @selenium.click "id=user_is_nominator"
      #      @selenium.select "id=user_organization_id", "label=American Association of Physics Teachers"
      @selenium.select "id=user_organization_id", "index=1"
      @selenium.type "id=user_password", "#{load_pswd}"
      @selenium.type "id=user_password_confirmation", "#{load_pswd}"
      @selenium.click "name=commit"
      @selenium.wait_for_page_to_load
      assert @selenium.is_text_present("User was successfully created.")
      assert @selenium.is_text_present('regular_user')
      @selenium.click "link=Users"
      @selenium.wait_for_page_to_load
    end
    @selenium.click "link=Users"
    @selenium.wait_for_page_to_load
    @selenium.click "link=Logout"
    @selenium.wait_for_page_to_load
  end

  def teardown
    @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end
end

