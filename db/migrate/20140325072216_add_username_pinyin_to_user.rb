class AddUsernamePinyinToUser < ActiveRecord::Migration
  def migrate(direction)
    super
    if direction == :up
      begin
        User.find_each{|user| user.generate_username_pinyin!}
      rescue Exception => e
        puts "#{e.inspect}"
      end
    end
  end
  def change
    add_column :users, :username_pinyin, :string
    add_index :users, :username_pinyin, unique: true
  end
end
