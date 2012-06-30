class AddPrimaryContactFieldsToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :primary_contact_name,   :string
    add_column :organizations, :primary_contact_title,  :string
    add_column :organizations, :primary_contact_phone,  :string
  end
end
