class AddIsApprovedToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :is_approved, :boolean
    add_column :users, :is_approved, :boolean

  end
end
