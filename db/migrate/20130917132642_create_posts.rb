class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references  :user,  index: true
      t.string      :state    
      t.string      :label
      t.string      :title
      t.text        :body
      
      t.integer     :comments_count, default: 0
      t.integer     :favorites_count, default: 0
      
      t.timestamps
    end
  end
end
