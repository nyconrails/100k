class AddSuperUserToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :super_user, :boolean
  end
end
