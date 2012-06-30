class DonorSubject < ActiveRecord::Base
  belongs_to :parent, :class_name => "DonorSubject"
  has_many :subsubjects, :foreign_key => :parent_id, :class_name => "DonorSubject", :dependent => :destroy
  validates :name, :presence => true, :uniqueness => true
  validates :ident, :presence => true, :uniqueness => true

  scope :sups, where(:parent_id => nil)

  def subject
    unless parent
      "subject#{ident.abs}"
    else
      "subject#{parent.ident.abs}"
    end
  end

  def is_sup?
    parent_id.blank?
  end
end
