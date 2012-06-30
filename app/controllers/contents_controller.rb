class ContentsController < ApplicationController

  def search_resources    
    @resource_contents=Content.where(:section=>'PORTAL_RESOURCES').where(["body ~* ?",".*#{params[:contentsearch]}.*"]).order(:slug)
    render :layout=>false    
  end

end
