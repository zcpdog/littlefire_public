class CreateReportTypes < ActiveRecord::Migration
  def change
    create_table :report_types do |t|
      t.string  :title
      t.text    :description
      
      t.timestamps
    end
  end
end
