class PagesController < ApplicationController
  def show
    @searchable = true
    render params[:slug]
  end

  def not_found
    redirect_to(root_path, :status=> :moved_permanently)
  end

  def search

  end
end
