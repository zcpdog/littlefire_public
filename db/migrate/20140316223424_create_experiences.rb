class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.references  :user,  index: true
      t.string      :state
      t.string      :name
      t.string      :title
      t.text        :content
      t.text        :content_plain_text
      t.integer     :related_deal_id, default: 0
      
      t.integer     :comments_count,  default: 0
      t.integer     :favorites_count, default: 0
      t.integer     :agree_count,     default: 0
      t.integer     :disagree_count,  default: 0
      
      t.timestamps
    end
  end
end
