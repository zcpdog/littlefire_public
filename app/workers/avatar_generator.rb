class AvatarGenerator
  include Sidekiq::Worker
  sidekiq_options :queue => :avatar
  
  def perform(user_id)
    user = User.find user_id
    if user.picture.nil?
      RubyIdenticon.create_and_save(user.email,"avatar.png")
      user.build_picture(image: File.open("avatar.png"))
      user.save
    end
  end
end