module ContentPlainText
  extend ActiveSupport::Concern
  included do
    before_save :update_content_plain_text, if: Proc.new {|obj|obj.new_record? or obj.content_changed?}
    before_save :update_name_and_title, if: Proc.new {|obj|obj.new_record? or obj.title_changed?}
  end
  
  protected
    def update_content_plain_text
      self.content_plain_text = Nokogiri::HTML(content).text.gsub(/&nbsp;/,"").strip
    end
    
    def update_name_and_title
      self.name = Nokogiri::HTML(title).text.gsub(/&nbsp;/,"").strip
      self.title = self.title.gsub(/<(\/)?p>/,"").strip
    end
end