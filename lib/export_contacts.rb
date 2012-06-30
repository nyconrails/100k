require 'csv'
class ExportContacts
   def export_contacts_from_organization(file)
     @organization = Organization.joins("FULL OUTER JOIN users on users.organization_id = organizations.id").order('name asc').uniq
    
     puts "Generating string...."
     csv_string = CSV.generate do |csv|
       csv << ["Contact_firstname","Contact_lastname","Contact_title","Org_name","Email","Contact_number","Partner_status",
"Is_nominator"]
       @organization.each do |org|
         org_users = org.users
         org_users.each do |user|
           csv << [user.first_name,user.last_name,user.title,org.name,user.email,user.phone,org.partner_status,
user.is_nominator]
        end         
      end 
    end
    puts "Writing CSV string into file....."
    File.open(file, "w") { |f| f.write csv_string; f.close;}
    puts "File closed."
  end
end
