require 'spec_helper'

describe "Vettings" do

  it "Authenticate user" do
    user = Factory(:nominee)
    application = Factory.create(:application, :user_id => user.id)
    visit admin_users_path
    admin_user = Factory(:admin_user)
    
    #we need to log in first
    fill_in('admin_user_email', :with => "admin@admin.com")
    fill_in('admin_user_password', :with => "admin")
    click_button "Login"

    page.should have_content("Signed in successfully.")

  end  
  
  it "Update vetting for logged in admin" do
    user = Factory(:nominee)
    application = Factory.create(:application, :user_id => user.id)
    admin_user = Factory(:admin_user)
   
    visit admin_application_path(application.id)
    controller.stub!(:restrict_soa_access).and_return(true)
    
    #this is counting us to the login page - we need to bypass
    page.should have_content("Vetting")
    
    #now lets update the vetting
  #  select('APPROVED', :from => 'vetting[status]')
  #  click_button "Update Vetting"
  #  page.should have_content("Vetting Updated")
  end  
  
end
