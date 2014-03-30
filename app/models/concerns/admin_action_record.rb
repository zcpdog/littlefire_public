module AdminActionRecord
  extend ActiveSupport::Concern
  included do
    before_save :update_user_of_admin, if: Proc.new{|obj|obj.user_id.nil?}
  end
  
  private
    def update_user_of_admin
      self.user = current_admin_user.user
    end
end