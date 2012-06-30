class AddPartnerName < ActiveRecord::Migration
  def up
    add_column :opportunities, :partner_name, :string, :default => nil, :null => true
  end

  def down
    remove_column :opportunities, :partner_name
  end
end
