class ApplicationsController < InheritedResources::Base

  def create
    
    @application = Application.where(:user_id=>current_user.id).first
    
    if @application.present?
      update_application
    else   
      save_application
    end
            
    respond_with() do |format|
      format.html {
       if ( params[:application][:type]=="submit")
       
          unless @application.is_submitted?
            @application.update_attribute('is_submitted',true)
            UserMailer.delay.nominator_application_submission_notice(@application)          
            #TODO: reset vetting status
          end
          
          #Make sure we touch the updated_at timestamp each time the application is submitted, even if already submitted
          @application.touch
          
          flash[:notice] = "Your application has been successfully submitted."
          render :template=>"/applications/thanks"
          

       else
          redirect_to root_path, :notice =>"Your application has been successfully saved."
       end   
      }
    end
  end
    
  private 

  def update_application

    @user = User.where(:id=>current_user.id).first
    @user.attributes = params[:user]
    @user.save
    
    @organization = Organization.where(:id=>current_user.organization_id).first
    @organization.attributes = params[:organization]    
    @organization.save
    
    @application.attributes = params[:application]    
    @application.save 
    
    if (@application.secondary_id.present?)
      @secondary = Secondary.where(:id=>@application.secondary_id).first
    else
      @secondary = Secondary.new  
    end   
    @secondary.attributes = params[:secondary]    
    @secondary.save 
    
    @application.update_attribute('secondary_id',@secondary.id)
    @application.update_attribute('user_id',@user.id)
      
  end
    
  def save_application

    @user = User.where(:id=>current_user.id).first
    @user.attributes = params[:user]
    @user.save
    
    @organization = Organization.where(:id=>current_user.organization_id).first
    @organization.attributes = params[:organization]    
    @organization.save
    
    @application = Application.new
    @application.attributes = params[:application]    
    @application.save 
    
    @secondary = Secondary.new
    @secondary.attributes = params[:secondary]    
    @secondary.save 
    
    @application.update_attribute('secondary_id',@secondary.id)
    @application.update_attribute('user_id',@user.id)
      
  end
end
