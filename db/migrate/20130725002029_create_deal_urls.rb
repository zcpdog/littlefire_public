class CreateDealUrls < ActiveRecord::Migration
  def change
    create_table :deal_urls do |t|
      t.references :deal, index: true
      t.string :type
      t.string :path

      t.timestamps
    end
  end
end
