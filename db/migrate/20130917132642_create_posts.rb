class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references  :user,  index: true
      t.references  :label, index: true
      
      t.string      :title
      t.text        :body
      t.string      :plain_text_title
      t.text        :plain_text_body
      t.string      :state
      
      t.integer     :comments_count, default: 0
      t.integer     :favorites_count, default: 0
      
      t.timestamps
    end
  end
end
