class CreateOrgtypes < ActiveRecord::Migration
  def change
    create_table :orgtypes do |t|
      t.string :title
      t.timestamps
    end
  end
end
