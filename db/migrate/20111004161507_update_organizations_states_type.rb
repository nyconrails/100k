class UpdateOrganizationsStatesType < ActiveRecord::Migration
  def up
    change_table :organizations do |t|
      t.change :state, :integer
    end
    
    rename_column :organizations, :state, :state_id
  end

  def down
    rename_column :organizations, :state_id, :state

    change_table :organizations do |t|
      t.change :state, :string
    end
      
  end
end
