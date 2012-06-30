class AddShowContactColumnToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :show_contact, :boolean, :default => true
  end
end
