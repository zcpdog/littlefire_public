module DealFactory
  class BaseConnection < ActiveRecord::Base
    if Rails.env.production?
      establish_connection :aws 
    else
      establish_connection :deal_factory
    end
    
    self.abstract_class = true
  end
end