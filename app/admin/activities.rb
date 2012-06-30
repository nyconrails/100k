ActiveAdmin.register Activity do
  controller.authorize_resource
    
  menu :label=>'Activity Log', :if => proc{ can? :manage, Activity }
  actions :index, :show
  
  

end