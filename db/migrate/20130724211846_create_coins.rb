class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.integer  :balance
      t.references  :user, index: true
      t.timestamps
    end
  end
end
