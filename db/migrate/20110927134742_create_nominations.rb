class CreateNominations < ActiveRecord::Migration

  def change
    create_table :nominations do |t|
      t.integer :nominator_id
      t.integer :nominee_id
      t.text :reason
      t.text :message
      t.integer :status_id
      
      t.timestamps
    end

  end
end
