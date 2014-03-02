class Link < ActiveRecord::Base
  belongs_to :user

  acts_as_taggable

  validates :url, :user, presence: true
  validates :url, link: true
end
