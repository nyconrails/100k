class CreateVettings < ActiveRecord::Migration
  def change
    create_table :vettings do |t|
      t.integer :user_id
      t.integer :application_id
      t.integer :status
      t.text :comments

      t.timestamps
    end
  end
end
