class Organization < ActiveRecord::Base
  PARTNER_STATUSES      = ["partner","funding_partner","new_partner"]
  COMMITMENT_CATEGORIES = ["increase_supply","retain_excellence","build_the_movement"]

  mount_uploader :avatar, AvatarUploader

  has_paper_trail

  attr_accessible :name, :address, :address2, :city, :state_id, :zip, :orgtype_id, :www, :avatar, :other,
    :partner_status, :commitment, :additional_commitment, :primary_contact_id, :secondary_contact_id,
    :commitment_category, :additional_commitment_category,
    :joined_at, :primary_contact_email, :secondary_contact_email,
    :primary_contact_name, :primary_contact_title, :primary_contact_phone
  attr_accessor :primary_contact_phone, :primary_contact_email, :primary_contact_title, :primary_contact_name

  validates :name, :presence=>true

  validates :primary_contact_id, :uniqueness => true, :allow_blank => true

  belongs_to :orgtype
  belongs_to :state
  belongs_to :primary_contact, :class_name=>'User'#, :primary_key=>'primary_contact_id'
  belongs_to :secondary_contact, :class_name=>'Secondary'#, :primary_key=>'secondary_contact_id'

  has_many :posts, :dependent => :destroy
  has_many :users
  has_many :secondaries


  liquid_methods :name

  scope :funding_partners, where(:partner_status=>'funding_partner')
  scope :admin_partners, where(["partner_status=? or partner_status=? or partner_status=?",'funding_partner','partner', 'new_partner'])
  scope :all_partners, where(["partner_status=? or partner_status=?",'funding_partner','partner'])
  scope :regular_partners, where(:partner_status=>'partner')
  scope :full_search, lambda{|n| where(
    ["commitment ~* :search_term or additional_commitment ~* :search_term or name ~* :search_term ", :search_term=>".*#{n}.*"])}
  scope :new_partners, where(:partner_status=>'new_partner')

  before_update :email_partners

  accepts_nested_attributes_for :primary_contact

  def primary_attributes
    primary_contact_id
  end

  def primary_contact_name
    primary_contact.try(:name)
  end

  def primary_contact_email
    primary_contact.try(:email)
  end

  def primary_contact_phone
    primary_contact.try(:phone)
  end

  def primary_contact_title
    primary_contact.try(:title)
  end

  def email_partners
    if self.partner_status.to_s=="partner"
      if self.partner_status.to_s!=Organization.where(:id=>self.id).first.partner_status.to_s
        #testuser = User.where(:email=>"bret@dblsystems.com").first
        User.where(:organization_id=>self.id).each do |partner|
          UserMailer.welcome_partner_new_site(partner).deliver
          #UserMailer.welcome_partner_new_site(testuser).deliver
        end
      end
    end
  end

  def commitment
    self[:commitment].html_safe unless self[:commitment].nil?
  end

  def additional_commitment
    self[:additional_commitment].html_safe unless self[:additional_commitment].nil?
  end

  def save_organization(organization_name, orgtype_id)
    #save for nominee
    self.name = organization_name
    (self.orgtype_id = orgtype_id) if orgtype_id.present?

    self.save!
    return self
  end
end
