class PagesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  def show
    @searchable = true
    render params[:slug]
  end

  def not_found
    redirect_to(root_path, :status=> :moved_permanently)
  end

  def search

  end

  def randompartner
    item = Organization.all_partners.random
    text = strip_tags(Hpricot.uxs item.commitment.gsub(/[[:cntrl:]]/, ''))
    render :json => {
                      :id => item.id,
                      :img => item.avatar.regular.url,
                      :title => item.name,
                      :commitment => item.commitment_category.humanize,
                      :text => text
                      }
  end

end
