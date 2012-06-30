class WelcomeController < ApplicationController
  before_filter :require_login, :only => :index
  
  def index
    if current_user.is_nominator
      @total_nominations = Nomination.where(:nominator_id=>current_user.id).count
    else
      @application = Application.where(:user_id=>current_user.id).first

      if @application.present?
        params[:user] = @application.user
        params[:secondary] = @application.secondary
        params[:organization] = current_user.organization
        params[:application] = @application

        if @application.is_submitted?
          render :template=>"/applications/thanks"
        end

      else
        params[:user] = current_user
        params[:organization] = current_user.organization
        params[:application] = Application.new
      end
    end
    respond_to do |format|
	format.html
	format.js
    end
  end
end
