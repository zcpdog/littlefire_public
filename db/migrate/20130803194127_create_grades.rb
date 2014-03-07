class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.references :gradable, polymorphic: true, index:true
      t.references :user, index: true
      t.boolean :agree

      t.timestamps
    end
  end
end
