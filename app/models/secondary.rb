class Secondary < ActiveRecord::Base

  attr_accessible :first_name, :last_name, :title, :email, :phone, :application_id
 
  def full_name
    self.first_name + " " + self.last_name
  end
   
end
# == Schema Information
#
# Table name: secondaries
#
#  id             :integer         not null, primary key
#  application_id :integer
#  first_name     :string(255)
#  last_name      :string(255)
#  title          :string(255)
#  email          :string(255)
#  phone          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

