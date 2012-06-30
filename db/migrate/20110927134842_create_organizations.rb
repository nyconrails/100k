class CreateOrganizations < ActiveRecord::Migration
  def self.up
        
    create_table :organizations do |t|
      t.string :name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.integer :orgtype_id
      t.timestamps
    end
    
  end
end
