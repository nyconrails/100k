class ChangeYearsToTextType < ActiveRecord::Migration
  def up
    change_column :applications, :year1, :text
    change_column :applications, :year2, :text
    change_column :applications, :year3, :text
    change_column :applications, :year4, :text
    change_column :applications, :year5, :text
    change_column :applications, :supp_year1, :text
    change_column :applications, :supp_year2, :text
    change_column :applications, :supp_year3, :text
    change_column :applications, :supp_year4, :text
    change_column :applications, :supp_year5, :text      
  end

  def down
  end
end
