class AddStuffToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :year5, :string
    add_column :applications, :supp_year4, :string
  end
end
