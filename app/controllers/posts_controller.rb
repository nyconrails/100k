class PostsController < ApplicationController
  before_filter :detect_organization

  def create
    authorize! :post, @organization
    @post = @organization.posts.new(params[:post])
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "Successfully posted status."
    else
      flash[:alert] = "Could not post status. Error: #{@post.errors.full_messages.join('. ')}"
    end
  end

  def destroy
    @post = @organization.posts.find(params[:id])
    if @post.destroy
      flash[:notice] = "Successfully deleted status."
    else
      flash[:alert] = "Could not delete this status. Error: #{@post.errors.full_messages.join('. ')}"
    end
    redirect_to :back
  end

  def delete
    @post = @organization.posts.find(params[:id])
    if @post.destroy
      flash[:notice] = "Successfully deleted status."
    else
      flash[:alert] = "Could not delete this status. Error: #{@post.errors.full_messages.join('. ')}"
    end
  end

  def update
    @post = @organization.posts.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = "Successfully updated status."
    else
      flash[:alert] = "Could not update post status. Error: #{@post.errors.full_messages.join('. ')}"
    end
  end

  private
  def detect_organization
    @organization ||= Organization.find(params[:organization_id])
  end
end
