class ArticleType < ActiveRecord::Base
  has_many   :aritcles
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  rails_admin do
    list do
      field :id
      field :code
      field :name
    end
    edit do
      field :name
      field :code
      field :description
    end
  end
end
