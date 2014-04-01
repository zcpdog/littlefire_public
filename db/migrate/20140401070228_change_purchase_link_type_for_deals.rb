class ChangePurchaseLinkTypeForDeals < ActiveRecord::Migration
  def change
    change_column :deals, :purchase_link, :text
  end
end
