namespace :data do
  desc "generate friendly id"
  task :generate_friendly_id => :environment do
    User.find_each{|user| user.generate_username_pinyin!}
    Deal.find_each{|deal|deal.generate_name_pinyin!}
    Discovery.find_each{|discovery|discovery.generate_name_pinyin!}
    Experience.find_each{|experience|experience.generate_name_pinyin!}
    Article.find_each{|article|article.generate_name_pinyin!}
  end
end