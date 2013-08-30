class CreateSyncBatches < ActiveRecord::Migration
  def change
    create_table :sync_batches do |t|
      t.integer :batch_id

      t.timestamps
    end
  end
end
