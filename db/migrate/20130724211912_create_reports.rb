class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references  :report_type, index: true
      t.references  :deal, index: true
      t.string      :ip
      t.string      :email  
      t.text        :content
      
      t.timestamps
    end
  end
end
