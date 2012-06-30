class AddPhonenumberToContactedorganization < ActiveRecord::Migration
  def up
    add_column :contacted_organizations, :phonenumber, :numeric
  end

  def down
    remove_column :contacted_organizations, :phonenumber
  end
end
