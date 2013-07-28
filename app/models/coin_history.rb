class CoinHistory < ActiveRecord::Base
  belongs_to  :coin
  belongs_to  :richable, polymorphic: true
end
