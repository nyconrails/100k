class Nomination < ActiveRecord::Base

  validates :reason, :presence => true 
  validates :nominee_id, :presence => true 
  validates :nominator_id, :presence => true 

  #Doesn't Really Get Set??
  belongs_to :user
  
  belongs_to :nominee, :class_name=>'User', :foreign_key=>:nominee_id
  belongs_to :nominator, :class_name=>'User', :foreign_key=>:nominator_id
  
  liquid_methods :message
  
  
  def save_nomination(nomination, nominee_id, nominator_id)
    self.reason = nomination[:reason]
    self.message = nomination[:message]
    self.nominee_id = nominee_id
    self.nominator_id = nominator_id
    self.save!
    return self
  end
  
end
# == Schema Information
#
# Table name: nominations
#
#  id           :integer         not null, primary key
#  nominator_id :integer
#  nominee_id   :integer
#  reason       :text
#  message      :text
#  status_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

