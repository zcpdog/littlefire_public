class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references  :user,  index: true
      t.references  :commentable, polymorphic: true, index: true
      t.integer     :parent_id, index: true
      t.text        :content
      t.text        :content_origin

      t.timestamps
    end
  end
end
