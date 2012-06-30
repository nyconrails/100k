class ChangeContactedorganizationQuestionToText < ActiveRecord::Migration
  def up
    change_table :contacted_organizations do |t|
      t.change :question, :text
    end
  end

  def down
    change_table :contacted_organizations do |t|
      t.change :question, :text
    end
  end
end
