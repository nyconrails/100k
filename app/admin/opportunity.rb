require "#{Rails.root}/lib/active_admin_views_pages_base.rb"

ActiveAdmin.register Opportunity do
  controller.authorize_resource

  index do
    column :program_name
    column "Partner" do |opp|
      if opp.partner
        link_to opp.partner.try(:name),
          admin_organization_path(opp.partner)
      else
        opp.partner_name
      end
    end
    column :location
    column :due_date
    column :details
    column :link
    default_actions
  end

  action_item :only => :index  do
    link_to "Import", :action => :import
  end

  collection_action :import, :method => :get do
  end

  collection_action :upload, :method => :post do
    file = params[:file]
    if file.blank?
      flash[:alert] = "Please choose csv file to import!"
      redirect_to :back
      return
    else
      import = Importer.new
      results = import.import_opportunities_from_csv(file.path)
      #filename = "#{Time.now.to_s(:long).gsub(/[\ \' \:\,]/,'-')}_import_#{file.original_filename}.csv"
      #if request.env['HTTP_USER_AGENT'] =~ /msie/i
       #response.headers['Pragma'] = 'public'
       #response.headers["Content-type"] = "text/plain"
       #response.headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
       #response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
       #response.headers['Expires'] = "0"
      #else
       #response.headers['Content-Type'] = 'text/csv; charset=iso-8859-1; header=present'
       #response.headers["Content-Disposition"] = "attachment; filename=\"#{filename}\""
      #end
      #render :text => csv_string
      msg = ["File #{file.original_filename.inspect} was processed."]
      if results[1] > 0
        msg << "There are #{results[1]} of #{results[0]+results[1]} rows invalid. Nothing was inserted to db."
        msg << "Log details:<br/><br/>"
      else
        msg << "Total #{results[0]} of #{results[0]} rows were inserted to db. Old data was removed from db."
      end
      # msg << results[2]
      if results[1] > 0
        flash[:alert] = msg.join(' ')
      else
        flash[:notice] = msg.join(' ')
      end
      redirect_to :back
    end
  end
end
