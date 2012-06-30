class SnapshotCurrentPrimaryContactInOrganization < ActiveRecord::Migration
  def up
    Organization.all.each do |org|
      if org.primary_contact
        puts "\nOrganization #{org.name.inspect}......"
        primary_user = org.primary_contact
        org.primary_contact_name  = primary_user.full_name
        org.primary_contact_title = primary_user.title
        org.primary_contact_phone = primary_user.phone
        primary_user.role = "organization_admin"
        if(primary_user.organization_id == org.id)
          puts "........change primary contact to primary user....#{primary_user.save}"
          puts "........save changes of organization..............#{org.save}"
          if(!primary_user.errors.full_messages.empty? || !org.errors.full_messages.empty?)
            puts "........error: #{primary_user.errors.full_messages.join('. ')}; #{org.errors.full_messages.join('. ')}"
          end
        else
          puts ".........ERROR: primary user does not belong to the organization"
        end
      end
    end
  end

  def down
    puts "Schema was rollback, but data still changed"
  end
end
