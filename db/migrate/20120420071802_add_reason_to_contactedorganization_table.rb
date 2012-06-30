class AddReasonToContactedorganizationTable < ActiveRecord::Migration
  def up
    add_column :contacted_organizations, :reason, :string
  end

  def down
    remove_column :contacted_organizations, :reason
  end
end
