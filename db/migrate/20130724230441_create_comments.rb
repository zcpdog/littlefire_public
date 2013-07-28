class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references  :user,  index: true
      t.references  :deal,  index: true
      t.integer     :parent_id, index: true
      t.text        :content
      t.timestamps
    end
  end
end
