class CreateViewpoints < ActiveRecord::Migration
  def change
    create_table :viewpoints do |t|
      t.references  :pointable, polymorphic: true
      t.references  :users, index: true
      t.boolean     :agree 
       
      t.timestamps
    end
  end
end
