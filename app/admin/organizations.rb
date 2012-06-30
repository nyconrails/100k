ActiveAdmin.register Organization do
  controller.authorize_resource
   
  menu menu :if => proc{ can? :manage, Organization }
  actions :all

  scope :all, :default=>true  
  scope :all_partners
  scope :funding_partners
  scope :regular_partners
  scope :new_partners

  sidebar :preview, :only => [:show, :edit] do
    h3 do
      link_to("CLICK TO PREVIEW!", organization_path(params[:id]), :target=>"_blank")
    end
  end

  index do
    column :name
    column :address
    column :city
    column :zip
    column "User Count" do |organization|
      "#{organization.users.count}"  
    end
    #column "Active", :is_active
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name, :required => true
      f.input :address, :required => true
      f.input :address2, :required => true
      f.input :city, :required => true
      f.input :state, :required => true
      f.input :zip, :required => true
      f.input :joined_at
    end
    
    f.inputs "Contacts" do 
      f.input :primary_contact, :collection => User.order("first_name ASC").all
      #f.input :secondary_contact
      f.input :primary_contact_email
      #f.input :secondary_contact_email
    end
    
    f.inputs "Type" do 
      f.input :orgtype, :required => true, :label=>'Organization Type'
      f.input :partner_status, :as=>:select, :collection=>Organization::PARTNER_STATUSES, :label=>'Partner Status<br>(switch from new_partner to partner<br>to make live)'.html_safe
    end
    
    f.inputs "Commitments" do 
      f.input :commitment_category, :as=>:select, :collection=>Organization::COMMITMENT_CATEGORIES
      f.input :commitment, :input_html => { :class => "ckeditor"}
      f.input :additional_commitment_category, :as=>:select, :collection=>Organization::COMMITMENT_CATEGORIES
      f.input :additional_commitment, :input_html => { :class => "ckeditor"}
    end
    
    f.inputs "Logo" do 
      f.input :avatar, :as=>:file
    end
    
     
    f.buttons
  end

# added on- 10-apr-2012 Exporting contacts
# Start add
  action_item :only => :index do
    link_to 'Export Contacts', :action => 'export_csv'
  end 
    
  collection_action :export_csv do    
    file = "export_contacts.csv"
    filepath= ("#{Rails.root}/public/docs/"+file)
    unless File.exists?(filepath)
      File.new(filepath, "w")
    end # End unless
    export = ExportContacts.new
    results = export.export_contacts_from_organization(filepath)
   
    send_data(File.read(filepath),
        :type => 'text/csv; charset=utf-8; header=present',
        :disposition => 'attachment',
        :filename => (file))
  end
# End add

end
