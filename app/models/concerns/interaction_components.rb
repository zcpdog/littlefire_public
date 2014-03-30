module InteractionComponents
  extend ActiveSupport::Concern
  included do
    has_many   :comments, as: :commentable, dependent: :destroy
    has_many   :favorites, as: :favorable, dependent: :destroy
    has_many   :grades, as: :gradable, dependent: :destroy
    has_many   :reports, as: :reportable, dependent: :destroy
  
    has_one   :picture, as: :imageable, dependent: :destroy
    accepts_nested_attributes_for :picture, allow_destroy: true
  
    has_one   :credit, as: :creditable, dependent: :destroy
    accepts_nested_attributes_for :credit, allow_destroy: true
  end
end