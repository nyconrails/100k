ActiveAdmin.register Upload do
  controller.authorize_resource

  menu :label=>"Upload", :if => proc{ can? :manage, Upload }
  actions :all, :except => [:destroy]

  index do
    column :name
    column "Link" do |item|
      link_to "http://100kstaging.nyconrails.com#{item.file.url}", item.file.url
    end
    default_actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Upload" do
      f.input :name
      f.input :file, :as => :file
    end

    f.buttons
  end

  show do |item|
    attributes_table do
      row :name
      row :link do
        link_to "http://100kstaging.nyconrails.com#{item.file.url}", item.file.url
      end
    end
    active_admin_comments
  end

end
