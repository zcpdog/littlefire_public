namespace :data do
  desc "generate avatar for user without avatar"
  task :generate_avatar => :environment do
    User.find_each do |user|
      if user.picture.nil?
        AvatarGenerator.perform_async(user.id)
        puts "generated avatar for user ===> #{user.username}"
      end
    end
  end
end