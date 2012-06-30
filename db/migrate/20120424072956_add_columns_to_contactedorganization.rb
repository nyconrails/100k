class AddColumnsToContactedorganization < ActiveRecord::Migration
  def change
    remove_column :contacted_organizations, :name
    remove_column :contacted_organizations, :title
    remove_column :contacted_organizations, :organization
    add_column :contacted_organizations, :firstname, :string
    add_column :contacted_organizations, :lastname, :string
  end
end
