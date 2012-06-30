class SearchController < ApplicationController
  def index
    @results = Donor::Search.find(params.reject{|k| ['action', 'controller'].include?(k.to_s)})
    render :layout => false
  end

  def donates
    params['showFacetCounts'] = true
    param = params.reject {|k,v| ['action', 'controller'].include?(k.to_s) || v.blank?}
    params = param
    @results = Donor::Search.find(param)
    render :layout => false
  end

  def opportunities
    params[:page] ||= 1
    keywords = params[:keywords]
    @opportunities = Opportunity.scoped

    params[:sort_by] ||= 'partner_name'
    if(['program_name', 'location', 'partner_name'].include?(params[:sort_by]))
      @opportunities = @opportunities.order("#{params[:sort_by]} ASC")
    end

    @opportunities = @opportunities.page(params[:page]).per(10)
    render :layout => false
  end
end
