class Post < ActiveRecord::Base
  include AASM
  paginates_per 20
  belongs_to :user
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :favorites, as: :favorable, dependent: :destroy
  has_many   :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true
  validates :title, length: { in: 10..255}
  validates :body, length: { in:100..50000}
end
