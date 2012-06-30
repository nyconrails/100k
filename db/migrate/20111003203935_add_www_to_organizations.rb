class AddWwwToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :www, :string
  end
end
