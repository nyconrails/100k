class AddOtherToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :other, :string
  end
end
