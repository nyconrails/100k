class Application < ActiveRecord::Base

  attr_accessible :id, :user_id, :primary_commitment, :collab_org, :description, :commitmentcat
  attr_accessible :year1, :year2, :year3, :year4, :year5, :org_commitment_type, :further_info, :add_info, :is_consent, :secondary_id, :vetting_id
  attr_accessible :supp_commitment, :supp_add_commitment, :supp_add_commitemnt_cat, :supp_year1, 
                  :supp_year2, :supp_year3, :supp_year4, :supp_year5, :supp_commitment_type, :supp_launch, :supp_further_info, :supp_add_info

  attr_accessible :avatar, :remote_avatar_url, :remove_avatar, :avatar_cache
  
  mount_uploader :avatar, AvatarUploader

  belongs_to :secondary
  belongs_to :user
  has_many :vettings
  
  
  scope :submitted, where(:is_submitted=>true)
  
  def status
    stale_vettings=self.vettings.where(["updated_at < ?", self.updated_at])
    
    statuses=self.vettings.collect {|v| v.status}
    statuses=statuses.compact.uniq
    
    case
      when stale_vettings.any?
        "RESUBMITTED" 
      when statuses.empty?, statuses.include?('PENDING')
        "PENDING"
      when statuses.include?('SECOND_REVIEW')
        "REVIEW"
      when statuses.include?('REJECTED')
        "REJECTED"
      when statuses.include?('APPROVED')
        "APPROVED"
      else
        "UNKNOWN"
      
    end      
  end
  
end
# == Schema Information
#
# Table name: applications
#
#  id                      :integer         not null, primary key
#  user_id                 :integer
#  primary_commitment      :text
#  collab_org              :text
#  description             :text
#  commitmentcat           :string(255)
#  year1                   :text
#  year2                   :text
#  year3                   :text
#  year4                   :text
#  org_commitment_type     :string(255)
#  further_info            :text
#  add_info                :text
#  avatar                  :string(255)
#  is_consent              :boolean
#  secondary_id            :integer
#  vetting_id              :integer
#  created_at              :datetime
#  updated_at              :datetime
#  is_submitted            :boolean         default(FALSE)
#  supp_commitment         :text
#  supp_add_commitment     :text
#  supp_add_commitemnt_cat :string(255)
#  supp_year1              :text
#  supp_year3              :text
#  supp_year5              :text
#  supp_commitment_type    :string(255)
#  supp_launch             :string(255)
#  supp_further_info       :text
#  supp_add_info           :text
#  supp_year2              :text
#  year5                   :text
#  supp_year4              :text
#

