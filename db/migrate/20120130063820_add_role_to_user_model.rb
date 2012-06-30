class AddRoleToUserModel < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, :default => 'regular_user'
  end
end
