class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.integer   :partner_id
      t.string    :partner_name
      t.string    :program_name
      t.string    :location
      t.string    :due_date
      t.text      :details
      t.string    :link
      t.text      :additional
      t.string    :video

      t.timestamps
    end
  end
end
