require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
require 'nokogiri'
require File.dirname(__FILE__) + '/login_org_admin.rb'
include LoginOrgAdmin

class OrgadminAccessingMysettingsPage < Test::Unit::TestCase
  def setup
    @verification_errors = []
    @selenium, @admin_email, @admin_fname, @admin_lname, @admin_title = LoginOrgAdmin.share_admin_instance
    p "Org admin accessing personal profile."
  end
  
  def test_org_admin_accessing_my_settings_page
    @selenium.click "link=Partner Login"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("Hello, " + @admin_fname)
    @selenium.click "link=My Settings"
    @selenium.wait_for_page_to_load
    assert_equal @admin_email, @selenium.get_value("id=user_email")
    assert_equal @admin_fname, @selenium.get_value("id=user_first_name")
    assert_equal @admin_lname, @selenium.get_value("id=user_last_name")
    assert @selenium.is_text_present("Password Reset")
    assert_equal "Update", @selenium.get_value("name=commit")
    @selenium.click "link=My Organization"
    @selenium.wait_for_page_to_load
    assert !@selenium.is_text_present(@admin_email)
    assert !@selenium.is_text_present("Phone")
    @selenium.click "link=My Settings"
    @selenium.wait_for_page_to_load
    @selenium.type "id=user_first_name", ""
    @selenium.type "id=user_last_name", ""
    @selenium.type "id=user_title", ""
    @selenium.click "name=commit"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("Could not update your account")
    @selenium.type "id=user_first_name", "Admin"
    @selenium.type "id=user_last_name", "TestOrg_One"
    @selenium.type "id=user_title", "Admin_TestOrg_One"
    @selenium.type "id=user_phone", "1234567890"
    @selenium.click "id=user_show_contact"
    @selenium.click "name=commit"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("")
    user_email = @selenium.get_text("xpath=(.//*[@id='user_email'])")
    user_fname = @selenium.get_text("xpath=(.//*[@id='user_first_name'])")
    user_lname = @selenium.get_text("xpath=(.//*[@id='user_last_name'])")
    user_title = @selenium.get_text("xpath=(.//*[@id='user_title'])")
    user_phone = @selenium.get_text("xpath=(.//*[@id='user_phone'])")
    @selenium.click "link=My Organization"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("ORGANIZATION PROFILE")
    assert @selenium.is_text_present(user_fname)
    assert @selenium.is_text_present(user_lname)
    assert @selenium.is_text_present(user_title)
    assert @selenium.is_text_present(user_email)
    assert @selenium.is_text_present(user_phone)
    @selenium.click "link=My Settings"
    @selenium.wait_for_page_to_load
    @selenium.type "id=user_title", "Admin_One"
    @selenium.type "id=user_phone", ""
    @selenium.click "id=user_show_contact"
    @selenium.click "name=commit"
    @selenium.wait_for_page_to_load
    @selenium.type "id=post_body", "Hello, this is test on My settings page!!!!!"
    @selenium.click "xpath=(//input[@name='commit'])[2]"
    assert @selenium.is_text_present("Hello, this is test on My settings page!!!!!")
    @selenium.click "link=My Organization"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("100Kin10 STATUS NEWSFEED")
    assert @selenium.is_text_present("Organization Newsfeed")
    assert @selenium.is_text_present("Hello, this is test on My settings page!!!!!")
    @selenium.click "link=Log out"
    @selenium.wait_for_page_to_load
    begin
      assert @selenium.is_text_present("Partner Login")
    rescue Test::Unit::AssertionFailedError
      @verification_errors << $!
    end
    begin
      assert @selenium.is_text_present("Contact Us")
    rescue Test::Unit::AssertionFailedError
      @verification_errors << $!
    end
  end

  def teardown
    @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end
end
