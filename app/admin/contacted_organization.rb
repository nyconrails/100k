ActiveAdmin.register ContactedOrganization do
  controller.authorize_resource

  menu label: 'Contact Us'
  actions :all, :except => [:destroy]

  scope :all, :default=>true

  index do
    column :firstname
    column :lastname
    column :emailid
    #column "Active", :is_active
    default_actions
  end

  # form do |f|
  #   f.inputs "User" do
  #     f.input :firstname
  #     f.input :lastname
  #     f.input :last_name, :required => true
  #     f.input :title
  #     f.input :phone
  #     f.input :is_nominator
  #     f.input :organization, :collection=>Organization.where("partner_status='partner' or partner_status='funding_partner' or partner_status='new_partner'")
  #   end
  #
  #   f.inputs "Password" do
  #     f.input :password
  #     f.input :password_confirmation
  #   end
  #
  #   f.buttons
  # end


end