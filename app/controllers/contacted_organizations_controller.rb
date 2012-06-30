class ContactedOrganizationsController < ApplicationController
  def index
    @contactus_data ||= ContactedOrganization.new
    render :layout => 'pages'
  end

  def save_contact_us
    @contactus_data = ContactedOrganization.create(params[:contacted_organization])
    if !@contactus_data.errors.any?
      render "layouts/thankyou", :layout => 'pages'
      emailids = Content.insert 'contact_us_recipients'
      unless emailids.blank?
        emailids_set = ContactedOrganization.strip_html(emailids)
        UserMailer.contactus_application_form(@contactus_data, emailids_set).deliver       
      end
    else
      render :index, :layout => 'pages'
    end
  end
end
