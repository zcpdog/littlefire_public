class AddNamePinyinToDealDiscoveryExperienceArticle < ActiveRecord::Migration
  def migrate(direction)
    super
    if direction == :up
      Deal.find_each{|deal|deal.generate_name_pinyin!}
      Discovery.find_each{|discovery|discovery.generate_name_pinyin!}
      Experience.find_each{|experience|experience.generate_name_pinyin!}
      Article.find_each{|article|article.generate_name_pinyin!}
    end
  end
  def change
    add_column :deals,            :name_pinyin, :string
    add_column :discoveries,      :name_pinyin, :string
    add_column :experiences,      :name_pinyin, :string
    add_column :articles,         :name_pinyin, :string
    
    add_index :deals,             :name_pinyin
    add_index :discoveries,       :name_pinyin
    add_index :experiences,       :name_pinyin
    add_index :articles,          :name_pinyin
  end
end
