class CreateContactedOrganizations < ActiveRecord::Migration
  def change
    create_table :contacted_organizations do |t|
      t.string :name
      t.string :title
      t.string :organization
      t.string :emailid
      t.string :question
      t.timestamps
    end
  end
end
