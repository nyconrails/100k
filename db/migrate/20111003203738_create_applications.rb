class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :user_id
      t.text :primary_commitment
      t.string :collab_org
      t.text :description
      t.string :commitmentcat
      t.string :year1
      t.string :year2
      t.string :year3
      t.string :year4
      t.string :org_commitment_type
      t.text :further_info
      t.text :add_info
      t.string :avatar
      t.boolean :is_consent
      t.integer :secondary_id
      t.integer :vetting_id

      t.timestamps
    end
  end
end
