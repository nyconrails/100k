module ApplicationHelper

  def markdown(text)  
    Redcarpet.new(text, :autolink, :hard_wrap).to_html.html_safe  
  end  
  
  def format_breaks(text)
    text.gsub(/\r\n/, '<br>').html_safe
  end
  
  def is_active?(page_name)
    "menu_current_selected" if params[:action] == page_name && current_user.organization == @organization
  end

  def contactus_reasons
    array_of_reasons = []
    reasons = Content.insert "contact_us_reasons"
    if reasons.include?(',')
      parsed_object = reasons.split(',')
      parsed_object.each do |str|
        array_of_reasons << strip_tags(str)
      end
    else
      nokogiri_object = Nokogiri::HTML(reasons)
      parsed_object = nokogiri_object.xpath('//text()').text
      stripped_object = parsed_object.strip.scan(/\w+.*/i)
      stripped_object.each do |object|
        array_of_reasons << object.strip
      end
    end
    return array_of_reasons
  end
end
