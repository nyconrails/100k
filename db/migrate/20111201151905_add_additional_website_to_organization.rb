class AddAdditionalWebsiteToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :joined_at, :date
    add_column :organizations, :primary_contact_email, :string
    add_column :organizations, :secondary_contact_email, :string
  end
end
