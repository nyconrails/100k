class Ckeditor::Asset < ActiveRecord::Base

  if ENV['CMS_DATABASE_URL']     
    db = URI.parse(ENV['CMS_DATABASE_URL'])
    establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
    )
  end


  include Ckeditor::Orm::ActiveRecord::AssetBase
              
  delegate :url, :current_path, :size, :content_type, :filename, :to => :data
  
  validates_presence_of :data
end
# == Schema Information
#
# Table name: ckeditor_assets
#
#  id                :integer         not null, primary key
#  data_file_name    :string(255)     not null
#  data_content_type :string(255)
#  data_file_size    :integer
#  assetable_id      :integer
#  assetable_type    :string(30)
#  type              :string(30)
#  created_at        :datetime
#  updated_at        :datetime
#

