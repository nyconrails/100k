require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
require 'nokogiri'
require File.dirname(__FILE__) + '/login_org_admin.rb'
include LoginOrgAdmin

class UserAccessingorgNotAssignedTothem < Test::Unit::TestCase

  def setup
    @verification_errors = []
    @selenium, @admin_email, @admin_fname, @admin_lname, @admin_title = LoginOrgAdmin.share_admin_instance
    p "Org admin accessing other organization to which they do not belong."
  end
  
  def test_user_accessing_org_not_assigned_tothem
    @selenium.click "link=Partner Login"
    @selenium.wait_for_page_to_load
    @selenium.click "link=My Organization"
    @selenium.wait_for_page_to_load
    adminOne_org_url = @selenium.get_location
    p adminOne_org_url
    @selenium.click "link=Log out"
    @selenium.wait_for_page_to_load
    @selenium.click "link=Partner Login"
    @selenium.wait_for_page_to_load
    @selenium.type "xpath=(.//*[@id='email'])", "admin_testorg_two@locomotivellc.com"
    @selenium.type "xpath=(.//*[@id='password'])", "password"
    @selenium.click "name=commit"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("My Organization")
    assert @selenium.is_text_present("Admin")
    assert @selenium.is_text_present("My Settings")
    assert @selenium.is_text_present("Log out")
    assert @selenium.is_text_present("TestOrg_Two")
    @selenium.click "link=My Organization"
    @selenium.wait_for_page_to_load
    p adminOne_org_url
    @selenium.open adminOne_org_url
    p "Here user gets redirected to Partner Login page as he is not authorized to access other Orga's data"
    #    assert @selenium.is_text_present("ORGANIZATION PROFILE")
    #    assert @selenium.is_text_present(@admin_fname)
    #    assert @selenium.is_text_present(@admin_lname)
    #    assert @selenium.is_text_present(@admin_email)
    assert @selenium.is_text_present("Partner Login")
    assert @selenium.is_text_present("Contact Us")
    assert @selenium.is_text_present("About us")
    assert @selenium.is_text_present("Partners")
    assert @selenium.is_text_present("Commitments")
    assert @selenium.is_text_present("Take Action")
    assert @selenium.is_text_present("Press")
    @selenium.click "link=Partner Login"
    @selenium.wait_for_page_to_load
    @selenium.click "link=Admin"
    @selenium.wait_for_page_to_load
    @selenium.click "link=My Settings"
    @selenium.wait_for_page_to_load
    @selenium.click "link=Log out"
    @selenium.wait_for_page_to_load
  end

  def teardown
    @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end
end
