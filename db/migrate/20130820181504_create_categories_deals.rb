class CreateCategoriesDeals < ActiveRecord::Migration
  def change
    create_table :categories_deals, id: false do |t|
      t.references :category, index: true
      t.references :deal, index: true
    end
  end
end
