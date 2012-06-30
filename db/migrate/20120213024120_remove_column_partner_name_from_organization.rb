class RemoveColumnPartnerNameFromOrganization < ActiveRecord::Migration
  def up
    remove_column :opportunities, :partner_name
  end

  def down
    add_column :opportunities, :partner_name, :string
  end
end
