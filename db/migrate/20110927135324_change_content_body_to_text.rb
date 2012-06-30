class ChangeContentBodyToText < ActiveRecord::Migration
  def up
    change_table :contents do |t|
      t.change :body, :text
    end
  end

  def down
    change_table :contents do |t|
      t.change :body, :string
    end
  end
end
