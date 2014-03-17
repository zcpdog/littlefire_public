class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.references :creditable, polymorphic: true, index: true
      t.integer :points
      
      t.timestamps
    end
  end
end
