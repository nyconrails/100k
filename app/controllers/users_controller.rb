class UsersController < ApplicationController
  load_and_authorize_resource
  before_filter :detect_organization, :except => [:update_account]
  
  def index
    @users = @organization.users
  end

  def new
    @user = User.new
  end

  def create
    begin
      @user = @organization.users.new(params[:user])
      if @user.save
        # Added to send Welcome message to new User
        # Start Add
        if params[:send_welcome_email]
          @user.generate_reset_password_token
          UserMailer.send_welcome_email(@user).deliver
        end
        # End Add
        @user.update_attribute('show_contact', true)
        redirect_to organization_users_path(@organization), :notice => "New contact added successfully."
      else
        render :new
      end
    rescue Exception=>e
      puts e.to_s
    end
  end

  def edit
    @user = @organization.users.find(params[:id])
  end

  def update
    @user = @organization.users.find(params[:id])
    if(@user.update_attributes(params[:user]))
      # Added to send password_reset_instructions.
      # Start Add
      if params[:reset_password_email]
        @user.deliver_reset_password_instructions!      
      end
      # End Add
      redirect_to organization_users_path(@organization), :notice => "Contact information is updated succesfully."
    else
      render :action => :edit
    end
  end

  def destroy
    @organization = Organization.find(params[:organization_id])
    @user = @organization.users.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully removed user #{@user.full_name.inspect} from organization #{@organization.name.inspect}."
    else
      flash[:alert] = "Could not remove the user from organization! Error: #{@user.errors.full_messages.join('. ')}"
    end
    redirect_to organization_users_path(@organization)
  end

  def my_account
    puts '-------------------------------'
    @user = current_user
    respond_to do |format|
	format.html
	format.js
    end
  end

  def update_account
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your information was updated successfully."
    else
      flash[:alert] = "Could not update your account. Error: #{@user.errors.full_messages.join('. ')}"
    end
    redirect_to :back
  end

  def reset_password
    @user = @organization.users.find(params[:id])
    @user.deliver_reset_password_instructions!
    redirect_to :back, :notice => "Instructions have been sent to user' email address."
  end
  
  def welcome
    @user = @organization.users.find(params[:id])
    @user.generate_reset_password_token
    UserMailer.send_welcome_email(@user).deliver
    redirect_to :back, :notice => "Resend welcome mail to #{@user.email.inspect} successfully."
  end

  private

  def detect_organization
    @organization = params[:organization_id] ? Organization.find(params[:organization_id]) : Organization.find(current_user.organization_id)
  end
end
