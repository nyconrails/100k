require 'open-uri'

ActiveAdmin.register Organization do
  controller.authorize_resource
  controller do
    def user_for_paper_trail
      current_admin_user
    end
  end

  menu menu :if => proc{ can? :manage, Organization }
  actions :all

  scope :all, :default=>true
  scope :all_partners
  scope :funding_partners
  scope :regular_partners
  scope :new_partners

  sidebar :preview, :only => [:show, :edit] do
    h3 do
      link_to("CLICK TO PREVIEW!", organization_path(params[:id]), :target=>"_blank")
    end
  end

  sidebar :versions, :only => [:show, :edit] do
    org = Organization.find(params[:id])
    versions = org.versions
    if versions.size == 0
      "There are no older versions of this item."
    else
      output = "Click a link below to revert to an older version of this item.<br/><br />"
      versions.reverse.each do |v|
        unless v.whodunnit.to_i == 0 || v.object.nil? # system made a version
          whodunnit = AdminUser.find(v.whodunnit)

          # Create the links to view / revert to this previous version
          output << '<div>'
          output << "#{v.created_at.to_s[0..15]} by #{whodunnit.first_name}:&nbsp;&nbsp;"
          output << "#{ link_to('View', '#', class: 'version_data_trigger').to_s }&nbsp;&nbsp;"
          output << "#{ link_to('Revert', version_revert_path(v.id), confirm: "Are you sure you want to revert to this version?").to_s }"
          output << '</div>'

          # Output a div of the this older version's data for easy viewing.
          output << '<div class="version_data">'
          vd = YAML.load(v.object)

          # Replace orgtype_id with its name
          if vd['orgtype_id'].to_i > 0
            vd['org_type'] = Orgtype.find(vd['orgtype_id']).title
            vd.delete('orgtype_id')
          end

          # Replace contact id numbers with their names
          if vd["primary_contact_id"].to_i > 0
            usr = User.find(vd["primary_contact_id"])
            vd["primary_contact"] = "#{usr.first_name} #{usr.last_name}"
          end

          if vd["secondary_contact_id"].to_i > 0
            usr = Secondary.find(vd["secondary_contact_id"])
            vd["secondary_contact"] = "#{usr.first_name} #{usr.last_name}"
          end
          vd.delete('primary_contact_id')
          vd.delete('secondary_contact_id')

          # Some final cleanup
          vd.delete('id')

          # Finally output this hash of data into the div
          vd.each do |k,v|
            output << "<strong>#{k.humanize}</strong>: #{v}<br />"
          end
          output << '</div>'
        end
      end
      raw(output)
    end
  end

  index do
    column :name
    column :address
    column :city
    column :zip
    column "User Count" do |organization|
      "#{organization.users.count}"
    end
    #column "Active", :is_active
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name, :required => true
      f.input :address, :required => true
      f.input :address2, :required => true
      f.input :city, :required => true
      f.input :state, :required => true
      f.input :zip, :required => true
      f.input :joined_at
    end

    f.inputs "Contacts" do
      f.input :primary_contact, :collection => User.order("first_name ASC").all
      #f.input :secondary_contact
      f.input :primary_contact_email
      #f.input :secondary_contact_email
    end

    f.inputs "Type" do
      f.input :orgtype, :required => true, :label=>'Organization Type'
      f.input :partner_status, :as=>:select, :collection=>Organization::PARTNER_STATUSES, :label=>'Partner Status<br>(switch from new_partner to partner<br>to make live)'.html_safe
    end

    f.inputs "Commitments" do
      f.input :commitment_category, :as=>:select, :collection=>Organization::COMMITMENT_CATEGORIES
      f.input :commitment, :input_html => { :class => "ckeditor"}
      f.input :additional_commitment_category, :as=>:select, :collection=>Organization::COMMITMENT_CATEGORIES
      f.input :additional_commitment, :input_html => { :class => "ckeditor"}
    end

    f.inputs "Logo" do
      f.input :avatar, :as=>:file
    end


    f.buttons
  end


# added on- 10-apr-2012 Exporting contacts
# Start add
  action_item :only => :index do
    link_to 'Download Logos', :action => 'download_logos'
  end

  action_item :only => :index do
    link_to 'Export Contacts', :action => 'export_csv'
  end

  collection_action :download_logos do
    @orgs = Organization.all
  end

  collection_action :export_csv do
    file = "export_contacts.csv"
    filepath= ("#{Rails.root}/public/docs/"+file)
    unless File.exists?(filepath)
      File.new(filepath, "w")
    end # End unless
    export = ExportContacts.new
    results = export.export_contacts_from_organization(filepath)

    send_data(File.read(filepath),
        :type => 'text/csv; charset=utf-8; header=present',
        :disposition => 'attachment',
        :filename => (file))
  end

  member_action :downloadl do
    org = Organization.find(params[:id])
    open(URI.parse(org.avatar.to_s)) do |f|
      send_data f.read, :type => "image/jpeg", :disposition => "attachment"
    end
  end


# End add

end
