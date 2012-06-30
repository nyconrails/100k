class AddIsSubmittedToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :is_submitted, :boolean, :default => false
  end
end
