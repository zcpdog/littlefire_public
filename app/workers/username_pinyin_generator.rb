class UsernamePinyinGenerator
  include Sidekiq::Worker
  sidekiq_options :queue => :pinyin
  
  def perform(user_id)
    user = User.find user_id
    if user.username_pinyin.blank?
      user.username_pinyin = Pinyin.t(user.username, splitter: '')
      begin
        user.save!
      rescue ActiveRecord::RecordInvalid => e
        user.username_pinyin<<"#{user.id}"
        user.save
      end
    end
  end
end