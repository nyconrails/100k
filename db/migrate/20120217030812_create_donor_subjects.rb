class CreateDonorSubjects < ActiveRecord::Migration
  def change
    create_table :donor_subjects do |t|
      t.string :name, :null => false
      t.integer :ident, :null => false
      t.integer :parent_id

      t.timestamps
    end
  end
end
