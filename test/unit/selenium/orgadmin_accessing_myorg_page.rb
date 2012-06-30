require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
require 'nokogiri'
require File.dirname(__FILE__) + '/login_org_admin.rb'
include LoginOrgAdmin

class OrgadminAccessingMyorgPage < Test::Unit::TestCase
  def setup
    @verification_errors = []
    @selenium, @admin_email, @admin_fname, @admin_lname, @admin_title = LoginOrgAdmin.share_admin_instance
    p "Org admin accessing organization's profile data."
  end
  
  def test_org_admin_accessing_my_org_page
    @selenium.click "link=Partner Login"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("Community")
    assert @selenium.is_text_present("Resources")
    assert @selenium.is_text_present("Nomination")
    assert @selenium.is_text_present("Partner News")
    assert @selenium.is_text_present("Partner News")
    assert @selenium.is_text_present("100Kin10 STATUS NEWSFEED")
    assert @selenium.is_text_present("My Organization")
    assert @selenium.is_text_present("Admin")
    assert @selenium.is_text_present("My Settings")
    assert @selenium.is_text_present("Log out")
    @selenium.click "link=My Organization"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("ORGANIZATION PROFILE")
    assert @selenium.is_text_present("100Kin10 STATUS NEWSFEED")
    assert @selenium.is_text_present("COMMITMENT")
    assert @selenium.is_text_present("Organization Type:")
    assert @selenium.is_text_present("Date Joined:")
    assert @selenium.is_text_present("Address:")
    assert @selenium.is_text_present("CONTACTS")
    assert @selenium.is_text_present("Organization Newsfeed")
    @selenium.click "link=Log out"
    @selenium.wait_for_page_to_load
  end

  def teardown
    @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end
end
