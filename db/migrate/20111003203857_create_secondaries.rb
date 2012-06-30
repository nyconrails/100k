class CreateSecondaries < ActiveRecord::Migration
  def change
    create_table :secondaries do |t|
      t.integer :application_id
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
