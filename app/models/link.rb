class Link < ActiveRecord::Base
  belongs_to :deal
  validates :url, presence: true, length: { maximum: 255 }
  validates :deal, presence: true
end
