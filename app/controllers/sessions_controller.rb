class SessionsController < ApplicationController

  def create
    password = params[:password].strip
    email = params[:email].strip 
    user = login(email, password, params[:remember_me]) || login(email.downcase, password, params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "Logged in!"
    else
      Activity.log(user,"login: failure",[email,password])
      flash.now.alert = "Email or password was invalid"
      render :new 
    end
  end
  
  def new
    if current_user 
      redirect_back_or_to root_url, :notice => "Already logged in.  Logout if you want to change users." 
    end
   respond_to do |format|
	format.html
	format.js
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
 
  def index
     respond_to do |format|
	format.html
	format.js
    end
  end

end
