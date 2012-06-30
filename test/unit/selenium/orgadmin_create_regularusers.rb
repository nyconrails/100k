require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
require 'nokogiri'
require File.dirname(__FILE__) + '/login_org_admin.rb'
include LoginOrgAdmin

class OrgadminCreateRegularUsers < Test::Unit::TestCase
  def setup
    @verification_errors = []
    @selenium, @admin_email, @admin_fname, @admin_lname, @admin_title = LoginOrgAdmin.share_admin_instance
    p "Org admin creating regular users under their organization."
  end
  
  def test_org_admin_create_regular_users
    @selenium.click "link=Partner Login"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("My Organization")
    assert @selenium.is_text_present("Admin")
    assert @selenium.is_text_present("My Settings")
    assert @selenium.is_text_present("Log out")
    assert @selenium.is_text_present("100Kin10 STATUS NEWSFEED")
    @selenium.click "link=Admin"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("Add New Contact")
    assert @selenium.is_text_present("View All Contacts")
    assert @selenium.is_text_present("Organization Newsfeed")
    load_users_file = Nokogiri::XML(File.read("OrgAdmin_Regular_users.xml"))
    load_users_file.xpath('//regularuser/user').each do |user|
      user_email = user['email']
      user_fname = user['first_name']
      user_lname = user['last_name']
      user_title = user['title']
      user_phone = user['phone']
      @selenium.click "link=Add New Contact"
      @selenium.wait_for_page_to_load
      assert @selenium.is_text_present("Add New Contact")
      @selenium.type "id=user_email", "#{user_email}"
      @selenium.type "id=user_first_name", "#{user_fname}"
      @selenium.type "id=user_last_name", "#{user_lname}"
      @selenium.type "id=user_title", "#{user_title}"
      @selenium.type "id=user_phone", "#{user_phone}"
      @selenium.click "id=send_welcome_email"
      @selenium.click "name=commit"
      @selenium.wait_for_page_to_load
      assert @selenium.is_text_present("Organization Contacts")
      assert @selenium.is_text_present("#{user_fname}")
      assert @selenium.is_text_present("#{user_lname}")
      assert @selenium.is_text_present("#{user_title}")
    end
    @selenium.click "link=My Organization"
    @selenium.wait_for_page_to_load
    @selenium.click "link=Log out"
    @selenium.wait_for_page_to_load
  end

  def teardown
    @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end
end
