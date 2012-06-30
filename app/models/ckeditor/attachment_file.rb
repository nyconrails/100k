class Ckeditor::AttachmentFile < Ckeditor::Asset
  mount_uploader :data, CkeditorAttachmentFileUploader, :mount_on => :data_file_name
	
	def url_thumb
	  @url_thumb ||= begin
	    extname = File.extname(filename).gsub(/^\./, '')
      "/javascripts/ckeditor/filebrowser/images/thumbs/#{extname}.gif"
	  end
	end
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

