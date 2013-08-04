class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :deal, index: true
      t.string :type
      t.string :url

      t.timestamps
    end
  end
end
