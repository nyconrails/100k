class AddFieldsToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :supp_commitment, :text
    add_column :applications, :supp_add_commitment, :text
    add_column :applications, :supp_add_commitemnt_cat, :string
    add_column :applications, :supp_year1, :string
    add_column :applications, :supp_year3, :string
    add_column :applications, :supp_year5, :string
    add_column :applications, :supp_commitment_type, :string
    add_column :applications, :supp_launch, :string
    add_column :applications, :supp_further_info, :text
    add_column :applications, :supp_add_info, :text
  end
end
