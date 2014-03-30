class AddUserIdToAdminUsers < ActiveRecord::Migration
  def change
    add_reference :admin_users, :user, index: true
  end
end
