class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.references  :user,  index: true
      t.references  :merchant,  index: true
      t.string      :state
      t.string      :name
      t.string      :title
      t.text        :content
      t.string      :location
      t.datetime    :due_date
      t.boolean     :amazing_price
      t.string      :link
      t.string      :purchase_link
      
      t.integer     :comments_count, default: 0
      t.integer     :agree_count,  default: 0
      t.integer     :disagree_count,  default: 0
      t.integer     :favorites_count, default: 0
      
      t.timestamps
    end
  end
end
