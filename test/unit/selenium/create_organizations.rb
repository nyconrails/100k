require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
require 'nokogiri'
require File.dirname(__FILE__) + '/login_active_admin.rb'
include LoginActiveAdmin

class CreateOrganizations < Test::Unit::TestCase
  
  def setup
    @verification_errors = []
    @selenium= LoginActiveAdmin.browser_instance
    p "Super admin creating Organizations"
  end
  
  def test_create_organizations
    xml_document = File.read("list_organizations.xml")
    load_xml_file = Nokogiri::XML(xml_document)
    load_xml_file.xpath('//organizations/org').each do |node|
      load_name = node['name']
      load_add1 = node['add1']
      load_add2 = node['add2']
      load_city = node['city']
      load_zip = node['zip']
      load_year = node['year']
      load_month = node['month']
      load_day = node['day']
      load_primarycontact = node['primary_contact']
      load_primary_email = node['primary_email']
      load_orgtype = node['orgtype']
      load_partner = node['partner']
      load_commitment = node['commitment']
      load_addcommitment = node['add_commitment']
      @selenium.click "link=Organizations"
      @selenium.wait_for_page_to_load
      @selenium.click "link=New Organization"
      @selenium.wait_for_page_to_load
      assert @selenium.is_text_present("")
      @selenium.type "id=organization_name", "#{load_name}"
      @selenium.type "id=organization_address", "#{load_add1}"
      @selenium.type "id=organization_address2", "#{load_add2}"
      @selenium.type "id=organization_city", "#{load_city}"
      @selenium.select "id=organization_state_id", "label=Alaska"
      @selenium.type "id=organization_zip", "#{load_zip}"
      @selenium.select "id=organization_joined_at_1i", "#{load_year}"
      @selenium.select "id=organization_joined_at_2i", "#{load_month}"
      @selenium.select "id=organization_joined_at_3i", "#{load_day}"
      @selenium.select "id=organization_primary_contact_id", "#{load_primarycontact}"
      @selenium.type "id=organization_primary_contact_email", "#{load_primary_email}"
      @selenium.select "id=organization_orgtype_id", "label=#{load_orgtype}"
      @selenium.select "id=organization_partner_status", "#{load_partner}"
      @selenium.select "id=organization_commitment_category", "#{load_commitment}"
      @selenium.select "id=organization_additional_commitment_category", "#{load_addcommitment}"
      @selenium.click "name=commit"
      @selenium.wait_for_page_to_load
      assert @selenium.is_text_present("#{load_name}")
      assert @selenium.is_text_present("#{load_primarycontact}")
      assert @selenium.is_text_present("#{load_add1}")
      @selenium.click "link=Organizations"
      @selenium.wait_for_page_to_load
      assert @selenium.is_text_present("#{load_name}")
    end
    @selenium.click "link=Users"
    @selenium.wait_for_page_to_load
    @selenium.click "link=Edit"
    @selenium.wait_for_page_to_load
    @selenium.select "id=user_organization_id", "label=TestOrg_Two"
    @selenium.click "name=commit"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("User was successfully updated.")
    assert @selenium.is_text_present("organization_admin")
    @selenium.click "link=Users"
    @selenium.wait_for_page_to_load
    @selenium.click "xpath=(//a[contains(text(),'Edit')])[2]"
    @selenium.wait_for_page_to_load
    @selenium.select "id=user_organization_id", "label=TestOrg_One"
    @selenium.click "name=commit"
    @selenium.wait_for_page_to_load
    assert @selenium.is_text_present("User was successfully updated.")
    assert @selenium.is_text_present("organization_admin")
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
