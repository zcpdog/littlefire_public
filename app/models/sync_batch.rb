class SyncBatch < ActiveRecord::Base
  def self.current
    SyncBatch.last.try(:batch_id) || 0
  end
end
