class CreateArticleTypes < ActiveRecord::Migration
  def change
    create_table :article_types do |t|
      t.string  :name
      t.string  :code
      t.string  :description
      
      t.timestamps
    end
    add_index :article_types, :code, :unique => true
  end
end
