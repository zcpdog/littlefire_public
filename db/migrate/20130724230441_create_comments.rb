class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references  :user,  index: true
      t.references  :commentable, polymorphic: true
      t.integer     :parent_id, index: true
      t.text        :content
      
      t.integer     :agree_count,  default: 0
      t.integer     :disagree_count,  default: 0
      
      t.timestamps
    end
  end
end
