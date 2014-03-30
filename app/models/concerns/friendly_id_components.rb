module FriendlyIdComponents 
  extend ActiveSupport::Concern
  included do
    extend FriendlyId
    friendly_id :name_pinyin
    after_save  :update_name_pinyin!, if: Proc.new{|obj|obj.name_pinyin.blank?}
  end
  
  def generate_name_pinyin
    self.name_pinyin = (Pinyin.t(self.name.strip[0..20], splitter: '-').strip<<"-#{self.id}").
      gsub(/-+/,"-")
  end
  
  def generate_name_pinyin!
    self.generate_name_pinyin
    self.save
  end
  
  protected
    def update_name_pinyin
      if self.name.nil? or self.name.empty?
        self.update_name_and_title
      end
      self.generate_name_pinyin
    end
    
    def update_name_pinyin!
      if self.name.nil? or self.name.empty?
        self.update_name_and_title
      end
      self.generate_name_pinyin!
    end
end