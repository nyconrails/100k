class AddFieldToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :supp_year2, :string
  end
end
