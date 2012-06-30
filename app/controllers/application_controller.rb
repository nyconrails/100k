class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from ActionView::MissingTemplate, :with => :rescue_template
  rescue_from ActionController::RoutingError, :with => :rescue_404
  rescue_from ActiveRecord::RecordNotFound, :with => :rescue_404
  rescue_from ActionDispatch::ClosedError, :with => :rescue_closed
  helper_method :all_top_posts_of_organizations
  helper_method :all_posts
  helper :pages
  def all_posts
    posts.find(:all, :order=> 'created_at desc')
  end
  
  #$all_top_posts = all_top_posts_of_organizations
  
  # Added on 10-Mar-2012 to fetch all top posts from each organization
  # Start 
  def all_top_posts_of_organizations 
    posts = Hash.new
    @top_posts_by_org = Post.select("organization_id as org_id, max(created_at), max(id) as post_id").group("organization_id").order('max Desc').page(params[:page]).per(5) 
  end
  #End adding method all_top_posts_of_organizations
  
  def not_authenticated
    if request.flash[:notice]
      redirect_to login_url, :notice => request.flash[:notice]
    else
      redirect_to login_url, :alert => "First login to access this page."
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user || current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_admin_user
      redirect_to admin_dashboard_path, :alert => exception.message
    else
      redirect_to welcome_index_path, :alert => exception.message
    end
  end

  def rescue_template
    redirect_to root_path
  end

  def rescue_404
    redirect_to root_path
  end

  def rescue_closed
    redirect_to root_path
  end
  
  
end
