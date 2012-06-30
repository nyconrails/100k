ActiveAdmin.register AdminUser do
  controller.authorize_resource
  
  controller do 
    def update 
      if params[:admin_user][:password].blank? 
        params[:admin_user].delete(:password) 
        params[:admin_user].delete(:password_confirmation) if params[:admin_user][:password_confirmation].blank? 
      end 
      
      super 
    end
  
  end
  
   
  menu menu :if => proc{ can? :manage, AdminUser }
  actions :all, :except => [:destroy]

  index do
    column :email
    column :first_name
    column :last_name
    column :super_user
    column :editor
    default_actions
  end

  form do |f|
    f.inputs "User" do
      f.input :email, :required => true
      f.input :first_name, :required => true
      f.input :last_name, :required => true
      #f.input :super_user
      f.input :editor
    end
    
     f.inputs "Password" do
       #f.input :current_password 
       f.input :password
       f.input :password_confirmation
     end
    
    f.buttons
  end  


end