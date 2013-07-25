class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string  :title
      t.string  :key
      t.text    :description
      
      t.timestamps
    end
  end
end
