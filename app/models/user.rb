class User < ActiveRecord::Base
  authenticates_with_sorcery!

  ROLES = { :regular_user => "Regular User",
    :super_admin  => "Super Admin",
    :organization_admin => "Organization Admin" }

  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name,
    :reset_password_token, :title, :phone, :organization_id, :is_nominator,
    :is_primary_nominator, :is_approved, :show_contact

  validates_confirmation_of :password
#  validates_presence_of :password, :on => :create   # Modified on 14-Mar-2012 as this is no longer required.
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
 
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  #  validates :organization_id, :presence => { :if => :organization_admin? } # Removed by Kavita on 09-Mar-2012 as now we want all users to always belong to organization.
  validates :organization_id, :presence => true # Added by Kavita on 09-Mar-2012 as now we want all users to always belong to organization.
  validates :role, :inclusion => { :in => ROLES.keys.map(&:to_s) }

  belongs_to :organization
  has_one :nomination, :foreign_key=>:nominee_id
  has_one :application
  has_many :authored_nominations, :class_name=>'Nomination', :foreign_key=>:nominator_id
  has_many :posts, :dependent => :destroy   # Added on 14-Mar-2012 to delete all related posts.
  liquid_methods :email, :first_name, :last_name, :full_name, :organization, :reset_password_token

  scope :new_users, where(:is_approved=>true)
  scope :existing_users, where(["is_approved IS NULL or is_approved=?", false])

  require 'csv'

  ROLES.keys.each do |rol|
    define_method "#{rol}?" do
      self.role.to_s == rol.to_s
    end
  end

  #make email lower case so we can do case insensitive search with postgres
  def email=(email)
    self[:email]=email.strip.downcase
  end

  def self.find_by_email(email)
    super(email.strip.downcase)
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  def generate_reset_password_token
    if self[:reset_password_token].blank?
      self[:reset_password_token]=Sorcery::Model::TemporaryToken.generate_random_token
    end
    self[:reset_password_token]
  end

  def save_nominee(nominee, organization_id, password)

    self.first_name = nominee[:nominee_first_name]
    self.last_name = nominee[:nominee_last_name]
    self.email = nominee[:nominee_email]
    self.organization_id = organization_id
    self.title = nominee[:nominee_title]
    self.phone = nominee[:nominee_phone]

    self.is_nominator = false
    self.is_primary_nominator = false

    self.password=password
    self.password_confirmation=password

    unless (User.where(:email=>self.email).present?)
      #lets save - no duplicate record
      self.save!
      return self
    else
      return User.where(:email=>self.email).first
    end

  end

  def save_secondary(secondary, organization_id)
    self.first_name = secondary[:first_name]
    self.last_name = secondary[:last_name]
    self.email = secondary[:email]
    self.organization_id = organization_id
    self.title = secondary[:title]
    self.phone = secondary[:phone]

    self.reset_password_token = User.new.generate_reset_password_token

    self.is_nominator = true
    self.is_primary_nominator = false

    self.password=password=SecureRandom.base64(6)
    self.password_confirmation = self.password

    unless (User.where(:email=>self.email).present?)
      #lets save - no duplicate record
      self.save!
      return self
    else
      return User.where(:email=>self.email).first
    end

  end

  def update_nominator(nominator, organization_id)

    if(User.where(:email=>nominator[:nominator_email]).present?)
      current_nominator = User.where(:email=>nominator[:nominator_email]).first
    else
      current_nominator = User.new
    end

    current_nominator.first_name = nominator[:nominator_first_name]
    current_nominator.last_name = nominator[:nominator_last_name]
    current_nominator.email = nominator[:nominator_email]
    current_nominator.organization_id = organization_id
    current_nominator.title = nominator[:nominator_title]
    current_nominator.phone = nominator[:nominator_phone]
    current_nominator.is_primary_nominator = nominator[:is_primary_nominator]
    current_nominator.is_nominator = true

    if(User.where(:email=>nominator[:nominator_email]).present?)
      current_nominator.update_attributes(@nominator)
    else
      current_nominator.password=ActiveSupport::SecureRandom.base64(6)
      current_nominator.password_confirmation = self.password
      current_nominator.save!(current_nominator)
    end

    return current_nominator
  end


  def self.import_nominators_auto
    import_nominators('public/assets/nominators.csv', true)
  end

  def self.import_nominators(csv_file, send_email)
    errors=[]

    CSV.foreach(csv_file) do |row|

      organization = Organization.new(
        :name   => row[4],
        :address          => row[11],
        :address2 => row[12],
        :city          => row[13],
        :state_id          => (State.find_by_abbreviation(row[14].strip).id if row[14].present? && State.find_by_abbreviation(row[14].strip) ),
        :zip       => row[15]
      )
      organization.save!

      user = User.new(
        :first_name   => row[0],
        :last_name          => row[1],
        :email => row[2].strip,
        :title          => row[3],
        :organization_id => organization.id,
        :phone          => row[5],
        :password       => password = ActiveSupport::SecureRandom.base64(6),
        :password_confirmation => password,
        :is_nominator => true

      )
      if user.save
        UserMailer.delay.send_nomination_email(user, password) if send_email
      else
        errors << user.errors
      end
    end

    if errors.any?
      "There were #{errors.count} record(s) with errors processing the CSV file:\n"+errors.to_s
    end

  end

  def self.import_nominees(csv_file)
    errors=[]

    CSV.foreach(Rails.root+'db/csv/'+csv_file) do |row|



      nominator = User.find_or_initialize_by_email(row[7].strip.downcase)

      if nominator.new_record?
        nominator.first_name=row[5]
        nominator.last_name=row[6]
        nominator.organization=Organization.new(:name=>row[4],:orgtype_id=>Orgtype.last.id,:state_id=>State.last.id)
        nominator.is_nominator = true
        nominator.password="asdfas4523fsaf"
        nominator.password_confirmation="asdfas4523fsaf"
        if !nominator.save
          errors << nominator.errors
        end
      end

      nominee = User.find_or_initialize_by_email(row[3].strip.downcase)

      if nominee.new_record?
        nominee.organization = Organization.create(
          :name   => row[0],
          :orgtype_id => Orgtype.last.id,
          :state_id  => State.last.id
        )
        nominee.first_name=row[1]
        nominee.last_name=row[2]
        nominee.password="asdfas4523fsaf"
        nominee.password_confirmation="asdfas4523fsaf"

        nominee.nomination=Nomination.new(:reason=>"Previous Nominee",:nominator_id=>nominator.id)


        if !nominee.save
          errors << nominee.errors
        end
      else
        nomination=nominee.nomination
        if nomination.nil?
          errors << "Nomination is nil for #{nominee.email}"
        else
          nomination.nominator=nominator
          nomination.save
        end
      end

    end

    if errors.any?
      "There were #{errors.count} record(s) with errors processing the CSV file:\n"+errors.to_s
    end


  end

end# == Schema Information
#
# Table name: users
#
#  id                              :integer         not null, primary key
#  email                           :string(255)
#  crypted_password                :string(255)
#  salt                            :string(255)
#  first_name                      :string(255)
#  last_name                       :string(255)
#  title                           :string(255)
#  phone                           :string(255)
#  organization_id                 :integer
#  is_nominator                    :boolean
#  is_primary_nominator            :boolean
#  created_at                      :datetime
#  updated_at                      :datetime
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  last_login_at                   :datetime
#  last_logout_at                  :datetime
#  last_activity_at                :datetime
#

