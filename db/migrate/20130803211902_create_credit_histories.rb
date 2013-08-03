class CreateCreditHistories < ActiveRecord::Migration
  def change
    create_table :credit_histories do |t|
      t.references :creditable, polymorphic: true
      t.references :user, index: true
      t.integer :credit

      t.timestamps
    end
  end
end
