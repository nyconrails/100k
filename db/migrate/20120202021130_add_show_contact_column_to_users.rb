class AddShowContactColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_contact, :boolean, :default => false
  end
end
