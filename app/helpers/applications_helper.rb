module ApplicationsHelper

  def cool_heading(heading)
    header = heading.strip.split(' ')
    if header.size == 1
      heading
    elsif header.size == 2
      raw "<span class=\"contrast\">#{header[0]}</span> #{header[1]}"
    elsif header.size == 3
      raw "#{header[0]} <span class=\"contrast\">#{header[1]}</span> #{header[2]}"
    else
      raw "<span class=\"contrast\">#{header[0]}</span> " << header.each_with_index.map { |a,i| a.to_s if i != 0 }.join(' ')
    end
  end

end
