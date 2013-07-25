class CreateImages < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references  :imageable, polymorphic: true
      t.string      :humanized_file_name
      t.string      :image_file_name
      t.string      :image_content_type
      t.integer     :image_file_size
      
      t.timestamps
    end
  end
end
