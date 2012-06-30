class AddPartnerFieldsToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :partner_status, :string
    add_column :organizations, :commitment, :text
    add_column :organizations, :additional_commitment, :text
    add_column :organizations, :primary_contact_id, :integer
    add_column :organizations, :secondary_contact_id, :integer
  end
end
