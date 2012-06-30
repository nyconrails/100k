module SearchHelper
  def filter_search_breadcrumbs(params)
    words = []
    words << Donor::Search::SORTED.select{|k,v| v==params['sortBy'].to_i}.keys.first
    words << State.find_by_abbreviation(params['state']).try(:name)
    words << params['cityName']
    param = params.select{|k,v| k.to_s.include?('subject') && v.to_i != 0 }.map{|k,v| v}
    subjects = DonorSubject.where(:ident => param)
    subjects.each do |sub|
      words << sub.parent.try(:name)
      words << sub.name
    end
    words << params['keywords']
    words.compact.reject{|k| k.blank?}.uniq.join(" > ")
  end
end
