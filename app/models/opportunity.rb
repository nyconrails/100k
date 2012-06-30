class Opportunity < ActiveRecord::Base
  belongs_to :partner, :class_name => "Organization"
end
