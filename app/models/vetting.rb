class Vetting < ActiveRecord::Base

  #self.partial_updates = false
  
  after_save :update_organization
  
  belongs_to :application
  belongs_to :user, :class_name=>'AdminUser', :foreign_key=>:user_id
  
  #STATUSES=%w(APPROVED REJECTED PENDING SECOND_REVIEW)
  STATUSES=%w(APPROVED REJECTED SECOND_REVIEW)

  def status_text
    if self.application && self.updated_at && (self.updated_at < self.application.updated_at)      
      "RESUBMIT - #{self.status}"
    else  
      self.status
    end
  end
  
  def touch_record
    logger.info "touch record called"
  end
  
  def update_organization 

    if self.status=="APPROVED"
      #todo - set is_approved back to false when the organization is moved into "partner" status
      user = User.where(:id=>self.application.user.id).first 
      user.update_attributes(:is_nominator=>true, :is_approved=>true, :reset_password_token=>User.new.generate_reset_password_token)
        
      #secondary = Secondary.where(:id=>self.application.secondary.id).first 
      #secondary.update_attributes(:is_nominator=>true, :is_approved=>true)
      organization = Organization.where(:id=>self.application.user.organization.id).first
      organization.update_attributes(:partner_status=>"new_partner", :avatar=>self.application.avatar, :commitment=>self.application.primary_commitment, :primary_contact_id=>self.application.user_id, :secondary_contact_email=>self.application.secondary.email, :primary_contact_email=>self.application.user.email,:commitment_category=>self.application.commitmentcat, :secondary_contact_id=>self.application.secondary_id, :joined_at=>Time.now)
      
      #migrate the secondary_id to the main user table
      User.new.save_secondary(self.application.secondary, self.application.user.organization.id)

    end
  
    
    #run this on prod on init
    #Vetting.all.each do |vetting| ( vetting.update_organization ) end
  end
    
#   def status_text
#     case self.status
#       when 'APPROVED'
#         "Approved"
#       when 'REJECTED'
#         "Rejected"
#       when 'PENDING'
#         "Pending"
#       when 'SECOND_REVIEW'
#         "2nd Review"      
#       else
#         "Not Set" 
#     end
#   end
end
# == Schema Information
#
# Table name: vettings
#
#  id             :integer         not null, primary key
#  user_id        :integer
#  application_id :integer
#  status         :string(255)
#  comments       :text
#  created_at     :datetime
#  updated_at     :datetime
#

