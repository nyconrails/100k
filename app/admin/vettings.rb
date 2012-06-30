ActiveAdmin.register Vetting do 
  menu false

  controller do 
  
    def update 
      Vetting.find(params[:id]).touch
      super 
    end
  
    def show
      redirect_to admin_application_path(Vetting.find(params[:id]).application), :notice=>"Vetting Updated"
    end
  
  end

end