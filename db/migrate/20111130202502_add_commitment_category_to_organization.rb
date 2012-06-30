class AddCommitmentCategoryToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :commitment_category, :string
  end
end
