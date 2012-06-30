class RollbackColumnsToContactedorganization < ActiveRecord::Migration
  def change
    add_column :contacted_organizations, :title, :string
    add_column :contacted_organizations, :organization, :string
  end
end
