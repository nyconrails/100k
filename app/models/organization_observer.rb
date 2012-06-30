# Added on 7-Mar-2012 to reassign role to user's primary_contact when new Organization is created
# Start Modification
class OrganizationObserver < ActiveRecord::Observer
  observe :organization

  def after_save(model)
    @organization = Organization.find(model.id)
    unless @organization.primary_contact_id.nil?
      @user = User.find(@organization.primary_contact_id)
      @user.update_attribute('role', 'organization_admin')
    end
  end
end
# End Modification