class ContactedOrganization < ActiveRecord::Base
  
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :emailid, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :reason, :presence => true
  validates :phonenumber, :format => { :with => /(^(\+?\-? *[0-9]+)([,0-9 ]*)([0-9 ])*$)|(^ *$)/i, :message => "Invalid Phone number." }

  def self.strip_html(object)
    nokogiri_ob = Nokogiri::HTML(object)
    parsed_ob = nokogiri_ob.xpath('//text()').text
    stripped_ob1 = parsed_ob.strip.scan(/\w+@.*/i)
    if stripped_ob1.is_a?(Array)
      stripped_ob2 = []
      stripped_ob1.each do |ob|
        stripped_ob2 << ob.strip
      end
      stripped_ob3 = stripped_ob2.join(',')
    end
    return stripped_ob3
  end
end
