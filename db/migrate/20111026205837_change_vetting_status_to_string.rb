class ChangeVettingStatusToString < ActiveRecord::Migration
  def up
    change_column :vettings, :status, :string
  end

  def down
  end
end
