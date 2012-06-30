class OrganizationsController < ApplicationController
  load_and_authorize_resource

  skip_authorize_resource :only => :edit

  before_filter :require_login, :except=>[:show]
  before_filter :load_resource
  before_filter :authorize_organization, :except=>[:show]
  respond_to :html, :json
  
  def index
  end

  def update
    if @organization.update_attributes(params[:organization])
      redirect_to edit_organization_path(@organization), :notice=>"Organization changes saved."
    else
      redirect_to edit_organization_path(@organization), :notice=>"There was an error saving the changes."
    end
  end

  def edit
    @users = @organization.users  # Added on 13-Mar-2012 to provide Editable Screen to Regular Users in Admin Section.
  end

  def show
    @users = @organization.users  #Added on 9-Mar-2012 to lists users under an organization.
    (redirect_to(login_path) if current_admin_user.blank?) if current_user.blank?
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  private

  def authorize_organization
    redirect_to :root,:notice=>"You are not authorized to edit that organization." unless @organization==@current_user.organization
  end

  def load_resource
    @organization=Organization.find(params[:id])
  end
end
