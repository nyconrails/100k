module ApplicationsHelper

  def cool_heading(heading)
    header = raw heading.strip.gsub('&', '<span class="contrast">&</span>')
  end

end
