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
      
      t.string      :display_title
      t.string      :display_body
      
      t.integer     :comments_count
      t.integer     :agree_count,  default: 0
      t.integer     :disagree_count,  default: 0
      t.integer     :favorites_count, default: 0
      
      t.string      :type
      t.string      :original_site
      t.string      :original_link
      t.boolean     :clone
      
      t.timestamps
    end
  end
end
