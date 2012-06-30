class AdminUser < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :editor
  
  has_many :vettings, :foreign_key=>'user_id'
  
  def update_attributes(params={})
    logger.debug "in update attributes with #{params}"
    if params[:password] && params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
      self.update_without_password(params)
    else
      super(params)
    end
  end
  
  
  def shortened_name
    #    if first_name && last_name
    if !(first_name.blank? || last_name.blank?)
      first_name + ' ' + last_name[0] + '.'
    else
      email.split('@')[0]
    end
  end
end
# == Schema Information
#
# Table name: admin_users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     not null
#  encrypted_password     :string(128)     not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  super_user             :boolean
#  first_name             :string(255)
#  last_name              :string(255)
#  editor                 :boolean
#

