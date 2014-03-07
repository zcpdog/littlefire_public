class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.references  :user,  index: true
      t.references  :merchant,  index: true
      t.string      :state
      t.string      :title
      t.text        :content
      t.text        :content_plain_text
      t.datetime    :due_date
      t.string      :purchase_link
      
      t.integer     :comments_count,  default: 0
      t.integer     :grades_count,    default: 0
      t.integer     :favorites_count, default: 0
      
      t.timestamps
    end
  end
end
