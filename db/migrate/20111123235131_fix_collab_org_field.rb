class FixCollabOrgField < ActiveRecord::Migration
  def up
    change_column :applications, :collab_org, :text
  end

  def down
  end
end
