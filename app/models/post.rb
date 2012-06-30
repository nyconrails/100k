class Post < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user

  validates :body, :presence => true
  validates :organization, :presence => true
  validates :user, :presence => true
end
