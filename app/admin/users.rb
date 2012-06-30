ActiveAdmin.register User do
  controller.authorize_resource
   
  menu menu :if => proc{ can? :manage, User }
  actions :all, :except => [:destroy]

  scope :all, :default=>true  
  scope :existing_users
  scope :new_users
  
  index do
    column :email
    column :first_name
    column :last_name
    column :title
    column :phone
    #column "Active", :is_active
    default_actions
  end

  form do |f|
    f.inputs "User" do
      f.input :email, :required => true
      f.input :first_name, :required => true
      f.input :last_name, :required => true
      f.input :title
      f.input :phone
      f.input :is_nominator
      f.input :organization, :collection=>Organization.where("partner_status='partner' or partner_status='funding_partner' or partner_status='new_partner'")
    end
    
    f.inputs "Password" do 
      f.input :password
      f.input :password_confirmation
    end
    
    f.buttons
  end  


end