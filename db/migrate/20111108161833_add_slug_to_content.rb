class AddSlugToContent < ActiveRecord::Migration
  def change
    add_column :contents, :slug, :string
    add_column :contents, :section, :string
  end
end
