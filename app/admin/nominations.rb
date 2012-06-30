ActiveAdmin.register Nomination do
  controller.authorize_resource
  
  menu menu :if => proc{ can? :manage, Nomination }

  actions :all, :except => [:destroy, :edit, :new]

  index do

    column "Nominee" do |nomination|
      @user = User.where(:id=>nomination.nominee_id).first 
      link_to @user.first_name + " " + @user.last_name + " [" + @user.email + "]", admin_nomination_path(nomination)
    end

    column "Nominator" do |nomination|
      @user = User.where(:id=>nomination.nominator_id).first 
      link_to @user.first_name + " " + @user.last_name + " [" + @user.email + "]", admin_nomination_path(nomination)
    end
        
    column "Actions" do |nomination|
      link_to "View", admin_nomination_path(nomination)
    end
  
  end


  csv do
    
    #TODO - this should be refactored but we're under a tight deadline.
    column("Nominee Organization") do |nomination| 
      @nominee = User.where(:id=>nomination.nominee_id).first
      @nominee.organization.name
    end
    
    column("Nominee") do |nomination| 
      @nominee = User.where(:id=>nomination.nominee_id).first
      @nominee.first_name + " " + @nominee.last_name
    end

    column("Nominee Email ") do |nomination| 
      @nominee = User.where(:id=>nomination.nominee_id).first
      @nominee.email
    end

    column("Nominee Title ") do |nomination| 
      @nominee = User.where(:id=>nomination.nominee_id).first
      @nominee.title
    end

    column("Nominee Phone ") do |nomination| 
      @nominee = User.where(:id=>nomination.nominee_id).first
      @nominee.phone
    end
    
    column("Nominator Organization") do |nomination| 
      @nominator = User.where(:id=>nomination.nominator_id).first
      @nominator.organization.name
    end            
            
    column("Nominator") do |nomination| 
      @nominator = User.where(:id=>nomination.nominator_id).first
      @nominator.first_name + " " + @nominator.last_name
    end

    column("Nominator Email ") do |nomination| 
      @nominator = User.where(:id=>nomination.nominator_id).first
      @nominator.email
    end

    column("Nominator Title ") do |nomination| 
      @nominator = User.where(:id=>nomination.nominator_id).first
      @nominator.title
    end

    column("Nominator Phone ") do |nomination| 
      @nominator = User.where(:id=>nomination.nominator_id).first
      @nominator.phone
    end

        
    column :reason
    column :message

    column :created_at
        
  end

  show do
    
    div do
      @nominee = User.where(:id=>nomination.nominee_id).first 
      @nominator = User.where(:id=>nomination.nominator_id).first
      
      simple_format( "<h3>Nominee Information</h3>" +
        "<strong>Organization: </strong>#{@nominee.organization.name}<br>" + 
         "<strong>Title: </strong>#{@nominee.title}<br> " + 
         "<strong>Name: </strong>#{@nominee.first_name} #{@nominee.last_name}<br>" + 
         "<strong>Email: </strong>#{@nominee.email}<br>" + 
         "<strong>Phone: </strong>#{@nominee.phone}<br><br/>"+
         "<h3>Nominator Information</h3> " +
         "<strong>Organization: </strong>#{@nominator.organization.name}<br>" + 
         "<strong>Title: </strong>#{@nominator.title}<br> " + 
         "<strong>Name: </strong>#{@nominator.first_name} #{@nominator.last_name}<br>" + 
         "<strong>Email: </strong>#{@nominator.email}<br> " + 
         "<strong>Phone: </strong>#{@nominator.phone}<br> " + 
         "<br><h3>Reason</h3>#{nomination.reason}<br> " + 
         "<br><h3>Message</h3>#{nomination.message}")
    end
  end
          
end
