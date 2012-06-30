class AddEditorFieldToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :editor, :boolean
  end
end
