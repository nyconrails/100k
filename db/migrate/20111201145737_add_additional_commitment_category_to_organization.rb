class AddAdditionalCommitmentCategoryToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :additional_commitment_category, :string
  end
end
