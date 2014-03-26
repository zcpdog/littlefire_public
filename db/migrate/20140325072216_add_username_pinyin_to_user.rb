class AddUsernamePinyinToUser < ActiveRecord::Migration
  def migrate(direction)
    super
    if direction == :up
      User.find_each{|user| user.generate_username_pinyin!}
    end
  end
  def change
    add_column :users, :username_pinyin, :string
    add_index :users, :username_pinyin
  end
end
