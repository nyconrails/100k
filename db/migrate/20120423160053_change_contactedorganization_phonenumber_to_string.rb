class ChangeContactedorganizationPhonenumberToString < ActiveRecord::Migration
  def up
    change_table :contacted_organizations do |t|
      t.change :phonenumber, :string
    end
  end

  def down
    change_table :contacted_organizations do |t|
      t.change :phonenumber, :numeric
    end
  end
end
