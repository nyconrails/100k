ActiveAdmin.register Content do
  controller.authorize_resource
  
  menu :label=>"Content" ,:if => proc{ can? :manage, Content } 
  
  index do
    column :title
    column :lede
    column :section
    column :slug
    #column "Active", :is_active
    default_actions
  end

  form do |f|
    f.inputs "Content" do
      f.input :title
      f.input :lede, :label=> "Description", :hint=>"A quick description, for internal use."
      f.input :slug, :hint=>"Content key, only letter, numbers, _ and - (no spaces or special characters)."
      f.input :section, :hint=>"Used to group content on pages."
      f.input :body, :as => :text, :input_html => {:cols=>5, :height => 200, :class => :ckeditor }, :label=>false 
      #f.input :is_active, :as=> :boolean
    end
    
    f.buttons
  end    
end
