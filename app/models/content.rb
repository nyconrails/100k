require 'uri'
require 'nokogiri'

class Content < ActiveRecord::Base

  if ENV['CMS_DATABASE_URL']
    db = URI.parse(ENV['CMS_DATABASE_URL'])
    establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
    )
  end

  @render_variables = {}

  validates :title, :slug, :presence=>true
  validates :slug, :uniqueness=>true
  validates :slug, :format=>{:with=>/\A[A-Za-z\_\-0-9]+\Z/, :message=>'must contain only letters, numbers, _ and -'}


  def slug=(slug)
    self[:slug]=slug.downcase
  end

  def subsections
    return [] if section.blank?
    Content.where(:section=>section).where("id!=#{id}").order('slug ASC')
  end

  def parse_body(tag)
    Nokogiri::HTML(body).xpath("//#{tag}")
  end

#   def render_block
#     render_safe_fields [:title,:lede,:body]
#     self
#   end
#
#   def render_safe_fields(fields)
#     fields.each do |field|
#       template = Liquid::Template.parse(self[field])
#       self[field]=(template.render @render_variables).html_safe
#     end
#   end

  def render_field(field)
    template = Liquid::Template.parse(self[field])
    (template.render @render_variables).html_safe
  end

  def render_field_without_tags(field,tags=[])
    rendered_text=render_field(field)
    parsed_text=Nokogiri::HTML(rendered_text)
    tags.each do |tag|
      parsed_text.at_css(tag).try(:remove)
    end
    parsed_text.to_html.html_safe
  end

  def self.insert(slug, variables={}, &block)
    @render_variables=variables
    content=find_or_create_by_slug(slug,:title=>slug.humanize)
    if content
      if block
        yield content
      else
        template = Liquid::Template.parse(content.body)
        (template.render variables).html_safe
      end
    end
  end


#TODO: find solution to CMS in staging fixture load deleting production CMS values because of connection link at top
#   def self.delete_all
#
#   end
#
#   def self.destroy_all
#
#   end




end
# == Schema Information
#
# Table name: contents
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  body       :text
#  is_active  :boolean
#  lede       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#  section    :string(255)
#

