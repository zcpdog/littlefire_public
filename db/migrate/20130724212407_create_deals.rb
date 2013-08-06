class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.references  :user,  index: true
      t.references  :merchant,  index: true
      t.references  :category,  index: true
      t.string      :state
      t.string      :title
      t.text        :body
      t.string      :location
      t.datetime    :due_date
      t.boolean     :amazing_price
      t.string      :purchase_link
      
      t.timestamps
    end
  end
end
