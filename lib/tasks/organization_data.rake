namespace :organizations do
  require 'csv'
  task :fetch_org_data => :environment do
    @organizations = Organization.select("id, name, primary_contact_id, primary_contact_email").order("id desc")
    directory = "#{Rails.root}/public/docs"
    Dir.mkdir(directory) unless Dir.exists?(directory)
    puts "Creating file as #{directory}/organization.csv"
    filename = "#{directory}"+"/organization.csv"
    unless File.exists?(filename)
      File.new(filename, "w")
    end # End Unless
    puts "Generating string...."
    csv_string = CSV.generate do |csv|
      csv << ["Org_id", "Org_name", "primary_contact_id", "primary_contact_email"]
      @organizations.each do |organization|
        csv << [organization.id, organization.name, organization.primary_contact_id, organization.primary_contact_email]
      end # End each_loop
    end
    puts "Writing CSV string into file....."
    File.open(filename, "w") { |f| f.write csv_string; f.close;}
    puts "File closed."
  end # End task_do

  task :org_join_users => :environment do
    @joined_data = Organization.joins("FULL OUTER JOIN users on users.organization_id = organizations.id").uniq
    file = "#{Rails.root}/public/docs/organization_joined_users_data.csv"
    unless File.exists?(file)
      File.new(file, "w")
    end # End unless
    puts "Generating string...."
    csv_string = CSV.generate do |csv|
      csv << ["Org_id", "Org_name", "primary_contact_id", "primary_contact_email","User_id","User_email","User_firstname","User_lastname","User_role"]
      set_of_id = []
      @joined_data.each do |data|
        users = []
        users = data.users.order('role asc')
        unless set_of_id.include?(data.id)
          set_of_id << data.id
          if !users.empty?
            users.each do |user|
              csv << [data.id,data.name,data.primary_contact_id,data.primary_contact_email,user.id,user.email,user.first_name,user.last_name,user.role]
            end
          else
            csv << [data.id,data.name,data.primary_contact_id,data.primary_contact_email,"","","","",""]
          end
        end
      end
    end
    puts "Writing CSV string into file....."
    File.open(file, "w") { |f| f.write csv_string; f.close;}
    puts "File closed."
  end #end task_do
end # End namespace
