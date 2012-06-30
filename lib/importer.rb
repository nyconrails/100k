require 'csv'
class Importer
  def import_opportunities_from_csv(path)
    stacked = []
    exceptions = [0]
    success = [0]
    log_path = "log/import_opportunities.csv"
    list_messages = []
    csv_string = CSV.generate do |errors|
    #CSV.open("#{Rails.root}/temp/#{log_path}", "wb") do |errors|
      errors << ['Row', 'Status', 'Message']
      begin
        file = File.read(path)
        csv = CSV.parse(file, :headers => true)
        row_num = 1
        csv.each do |row|
          row_num += 1
          begin
            #row = row.to_hash.with_indifferent_access
            opp = Opportunity.new
            partner_name = row[0] #row["Partner Name"]
            org = Organization.find_by_name(partner_name)
            opp.partner = org
            opp.partner_name  = partner_name
            opp.program_name  = row[1] #row["Program Name"]
            opp.location      = row[2] #row["Location"]
            opp.due_date      = row[3] #row["Due Date"]
            opp.details       = row[4] #row["Details"]
            opp.link          = row[5] #row["Website link for more info"]
            opp.additional    = row[6] #row["Additional Details"]
            opp.video         = row[7] #row["Video"]
            if opp.save
              success << 1
              stacked << opp
              errors << [row_num, "valid", nil]
            else
              exceptions << 1
              msg = []
              unless org
                msg << "Partner #{partner_name.inspect} does not exist"
              end
              msg << opp.errors.full_messages.join(', ')
              list_messages << ["<li><span class='row'>Row##{row_num}</span> errors occured: #{msg.join(', ')}</li><br/>"]
              errors << [row_num, "invalid", "Errors occurred: #{msg.join('. ')}"]
            end
          rescue Exception => ex
            exceptions << 1
            list_messages << ["<li><span class='row'>Row##{row_num}</span> exception occured: #{ex.message}</li><br/>"]
            errors << [row_num, "exception", "Exception occurred: #{ex.message}"]
          end
        end
      rescue Exception => ex2
        exceptions << 1
        list_messages << ["<li><span class='row'>Row#-1</span> exception occured: #{ex2.message}</li><br/>"]
        errors << [-1, "exception", "Exception occurred: #{ex2.message}"]
      end
    end

    if stacked.size > 0 && exceptions.sum > 0
      stacked.each do |op|
        op.destroy
      end
    else
      Opportunity.where("id not in (?)", stacked.map(&:id)).delete_all
    end
    list_messages = "<ul>"+list_messages.join(" ")+"</ul>"
    [success.sum, exceptions.sum, list_messages]
  end
end
