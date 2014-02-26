class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string  :name
      t.string  :link
      t.string  :domain
      t.string  :code
      
      t.timestamps
    end
  end
end
