class NominationsController < InheritedResources::Base

  helper :pages  
  before_filter :require_login
  
  def index 
    @total_nominations = Nomination.where(:nominator_id=>current_user.id).count
  end
  
  def create
    @total_nominations = Nomination.where(:nominator_id=>current_user.id).count

    respond_with() do |format|
      format.html {
        if (params[:preview]=="true")
          params[:preview]=nil
          render :template=>"/nominations/preview"
        end         
      } 
      format.js { 
        
        unless (params[:edit]=="true")

          @nominee_org = Organization.new.save_organization(params[:nominee_organization_name], nil)
          @nominator_org = Organization.new.save_organization(params[:nominator_organization_name], params[:nominator_orgtype])
          
          nominee_password=ActiveSupport::SecureRandom.base64(6)
          @nominee = User.new.save_nominee(params, @nominee_org.id, nominee_password)
          @nominator = User.new.update_nominator(params, @nominator_org.id)
          
          @nomination = Nomination.new.save_nomination(params, @nominee.id, @nominator.id)
          
          UserMailer.delay.nomination_confirmation(@nominee, @nominator, @nomination, nominee_password) 
          UserMailer.delay.nominee_confirmation(@nominee, @nominator, @nomination) 
                    
        end         
      
      } 
    end
  end

# Added on 20-April-2012 to add "Activity" link on the portal 
# Start 
  def activity
    if current_user
       @nominations = Nomination.where("nominator_id = '#{current_user.id}'")
       @organization = current_user.organization
    end
  end
# End
end
