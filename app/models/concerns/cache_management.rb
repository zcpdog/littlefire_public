module CacheManagement
  extend ActiveSupport::Concern
  included do
    after_save :expire_first_five_pages, if: Proc.new{|obj|obj.active?}
  end
  
  private
    def expire_first_five_pages
      Rails.cache.delete([self.class.name,"published",nil])
      [1..3].each{|i| Rails.cache.delete([self.class.name,"published",i])}
    end
end