ActiveAdmin.register Application do

  actions :all, :except => [:destroy, :edit, :new]

  scope :submitted, :default=>true
  scope :all

#   controller do 
#     def index 
#       @applications=Application.submitted
#     end
#   end

  index do

    column "Status", :status
    
    column "Name" do |application|
      application.user.full_name
    end
    
    column "Organization" do |application|
      application.user.organization && application.user.organization.name ||= "Undefined"
    end
    
    column "Title" do |application|
      application.user.title
    end
    
    column "Email" do |application|
      application.user.email
    end
    
    column "Phone" do |application|
      application.user.phone
    end
    
    column "Nominator" do |application|
      application.user.nomination && application.user.nomination.nominator.full_name ||= "Undefined"
    end
    
    column "Category", :commitmentcat
    
    column "Application" do |application|
      link_to "See Details", admin_application_path(application)
    end
    
#     column "Vetting" do |application|
#       link_to "Vetting", admin_application_path(application,:anchor=>'vetting')
#     end
  
  end
  
  show do
    # views/admin/applications/_show.html.erb 
    render 'show'       
  end
          
end
