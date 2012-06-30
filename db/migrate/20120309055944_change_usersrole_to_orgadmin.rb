class ChangeUsersroleToOrgadmin < ActiveRecord::Migration
  def change
    @organizations = Organization.where("primary_contact_id is NOT NULL")
    puts "Updating all #{@organizations.count} rows..."
    count = 1
    @organizations.each do |organization|
      user = User.find(organization.primary_contact_id)
      user.update_attribute('role','organization_admin')
      puts "#{count.to_s}\t\t#{user.id}\t\t#{user.first_name}"+" "+"#{user.last_name}"
      count = count +1
    end
  end
end
