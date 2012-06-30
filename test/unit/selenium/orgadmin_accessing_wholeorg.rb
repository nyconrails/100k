require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
require 'nokogiri'
require File.dirname(__FILE__) + '/login_org_admin.rb'
include LoginOrgAdmin

class OrgadminAccessingWholeorg < Test::Unit::TestCase

  def setup
    @verification_errors = []
    @selenium, @admin_email, @admin_fname, @admin_lname, @admin_title = LoginOrgAdmin.share_admin_instance
    p "Org admin accessing whole organization."
  end
  
  def test_orgadmin_accessing_wholeorg
    @selenium.click "link=Partner Login"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("")
    assert @selenium.is_text_present("Hello, " + @admin_fname)
    assert_equal "Community", @selenium.get_text("link=Community")
    assert_equal "Resources", @selenium.get_text("link=Resources")
    assert_equal "Nomination", @selenium.get_text("link=Nomination")
    assert_equal "Partner News", @selenium.get_text("link=Partner News")
    assert @selenium.is_text_present("Partner News")
    assert @selenium.is_text_present("100Kin10 STATUS NEWSFEED")
    assert_equal "My Organization", @selenium.get_text("link=My Organization")
    assert_equal "Admin", @selenium.get_text("link=Admin")
    assert_equal "My Settings", @selenium.get_text("link=My Settings")
    assert_equal "Log out", @selenium.get_text("link=Log out")
    @selenium.click "link=My Organization"
    @selenium.wait_for_page_to_load
    assert_equal "ORGANIZATION PROFILE", @selenium.get_text("css=div.leftprofile > h1")
    assert @selenium.is_text_present("100Kin10 STATUS NEWSFEED")
    assert @selenium.is_text_present("COMMITMENT")
    assert_equal "Organization Type:", @selenium.get_text("css=div.leftprofile > strong")
    assert_equal "Date Joined:", @selenium.get_text("//div[@id='contentWrapper']/div[2]/div/strong[2]")
    assert_equal "Address:", @selenium.get_text("//div[@id='contentWrapper']/div[2]/div/strong[3]")
    assert @selenium.is_text_present("CONTACTS")
    assert @selenium.is_text_present("Organization Newsfeed")
    @selenium.click "link=Admin"
    @selenium.wait_for_page_to_load
    assert @selenium.is_element_present("link=< back")
    assert @selenium.is_text_present("Date Joined:")
    assert @selenium.is_text_present("exact:Address:")
    assert_equal "Update Organization", @selenium.get_value("name=commit")
    assert_equal "Add New Contact", @selenium.get_text("link=Add New Contact")
    assert_equal "View All Contacts", @selenium.get_text("link=View All Contacts")
    assert @selenium.is_text_present("Organization Newsfeed")
    @selenium.click "link=My Settings"
    @selenium.wait_for_page_to_load
    assert_equal "< back", @selenium.get_text("link=< back")
    assert_equal "Contact Information", @selenium.get_text("css=div.content > h1")
    assert @selenium.is_text_present("Password Reset")
    assert_equal "Update", @selenium.get_value("name=commit")
    assert_equal "Post Status", @selenium.get_text("//div[@id='contentWrapper']/div[2]/h1[2]")
    assert @selenium.is_element_present("id=post_body")
    assert @selenium.is_element_present("xpath=(//input[@name='commit'])[2]")
    assert_equal "POST", @selenium.get_value("xpath=(//input[@name='commit'])[2]")
    @selenium.click "link=Log out"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("About us")
    assert @selenium.is_text_present("Partners")
    assert @selenium.is_text_present("Commitments")
    assert @selenium.is_text_present("Take Action")
    assert @selenium.is_text_present("Press")
    assert @selenium.is_text_present("LEARN MORE ABOUT US")
    assert @selenium.is_element_present("link=View Our Partners")
    assert @selenium.is_element_present("link=Read All FAQ")
    assert @selenium.is_element_present("link=LEARN MORE ABOUT US")
    assert @selenium.is_text_present("MORE ON COMMITMENTS")
  end

  def teardown
    @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end
end
