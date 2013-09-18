class CreateCategoriesPosts < ActiveRecord::Migration
  def change
    create_table :categories_posts, id: false do |t|
      t.references :category, index: true
      t.references :post, index: true
    end
  end
end
