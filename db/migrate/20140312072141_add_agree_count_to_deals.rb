class AddAgreeCountToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :agree_count, :integer, default: 0
    add_column :deals, :disagree_count, :integer, default: 0
  end
end
