class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references  :reportable, polymorphic: true, index: true
      t.string      :ip, index: true
      
      t.timestamps
    end
  end
end
