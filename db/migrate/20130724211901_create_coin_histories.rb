class CreateCoinHistories < ActiveRecord::Migration
  def change
    create_table :coin_histories do |t|
      t.references  :coin, index: true
      t.references  :richable, polymorphic: true
      
      t.timestamps
    end
  end
end
