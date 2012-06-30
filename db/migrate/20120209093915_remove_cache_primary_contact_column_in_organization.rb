class RemoveCachePrimaryContactColumnInOrganization < ActiveRecord::Migration
  def up
    remove_column :organizations, :primary_contact_name
    remove_column :organizations, :primary_contact_title
    remove_column :organizations, :primary_contact_phone    
  end

  def down
    add_column :organizations, :primary_contact_name,   :string
    add_column :organizations, :primary_contact_title,  :string
    add_column :organizations, :primary_contact_phone,  :string
  end
end
