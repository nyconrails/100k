class AddName2ToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :name, :string
  end
end
