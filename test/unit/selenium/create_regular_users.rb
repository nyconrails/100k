require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
require 'nokogiri'
require File.dirname(__FILE__) + '/login_active_admin.rb'
include LoginActiveAdmin

class CreateRegularUsers < Test::Unit::TestCase
  
  def setup
    @verification_errors = []
    @selenium= LoginActiveAdmin.browser_instance
    p "Super admin creating Regular users under organizations."
  end
  
  def test_create_regular_users
    xml_document = File.read("list_regular_users.xml")
    load_xml_file = Nokogiri::XML(xml_document)
    load_xml_file.xpath("//regularusers/user").each do |user|
      load_email = user["email"]
      load_fname = user["first_name"]
      load_lname = user["last_name"]
      load_title = user["title"]
      load_org = user["organization"]
      load_pswd = user["password"]
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
      @selenium.select "id=user_organization_id", "#{load_org}"
      @selenium.type "id=user_password", "#{load_pswd}"
      @selenium.type "id=user_password_confirmation", "#{load_pswd}"
      @selenium.click "name=commit"
      @selenium.wait_for_page_to_load
      assert @selenium.is_text_present("User was successfully created.")
      assert @selenium.is_text_present("#{load_email}")
      assert @selenium.is_text_present("#{load_org}")
      assert @selenium.is_text_present("regular_user")
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
