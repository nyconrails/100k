class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :id
      t.integer :trackable_id
      t.string :trackable_type
      t.string :action
      t.text :data

      t.timestamps
    end
  end
end
