class DealUrl < ActiveRecord::Base
  belongs_to :deal
  URL_TYPE = ['original','coupon']
  
end
