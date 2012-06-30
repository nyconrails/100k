class Activity < ActiveRecord::Base

  def self.log(model, message, data) 
    create(:trackable_type=>(model ? model.class.name : 'nil'), :trackable_id=>(model ? model.id : 0), :action=>message, :data=>data)
  end
end
# == Schema Information
#
# Table name: activities
#
#  id             :integer         not null, primary key
#  trackable_id   :integer
#  trackable_type :string(255)
#  action         :string(255)
#  data           :text
#  created_at     :datetime
#  updated_at     :datetime
#

