class Coin < ActiveRecord::Base
  belongs_to  :user
  has_many    :coin_histories, dependent: :destroy
end
