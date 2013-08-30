module DealFactory
  class Deal < DealFactory::BaseConnection
    self.table_name = :deal
    
    def self.recent
      find_by_sql("select * from deal where id > #{SyncBatch.current}")
    end 
    
  end
end