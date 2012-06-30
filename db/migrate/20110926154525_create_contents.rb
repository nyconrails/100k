class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.string :body
      t.boolean :is_active
      t.string :lede

      t.timestamps
    end
  end
end
