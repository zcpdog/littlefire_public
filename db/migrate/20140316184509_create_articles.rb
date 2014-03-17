class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string      :name
      t.string      :title
      t.text        :content
      t.text        :content_plain_text
      t.references  :article_type, index: true
      t.string      :state
      
      t.integer     :comments_count,  default: 0
      t.integer     :favorites_count, default: 0
      t.integer     :agree_count,     default: 0
      t.integer     :disagree_count,  default: 0
      
      t.timestamps
    end
  end
end
