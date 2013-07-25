class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string  :name
      t.string  :url
      t.string  :status
      
      t.timestamps
    end
  end
end
