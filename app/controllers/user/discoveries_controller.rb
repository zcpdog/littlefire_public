class User::DiscoveriesController < UserController
  def index
    @obj_class = Discovery.name.downcase.pluralize
    @objs = Discovery.includes(:picture).owned_by(@user).month_of(@current_time)
    @stop = beyond_date?
    respond_to do |format|
      format.html {render "user/show"}
      format.js {render "user/common/index"}
    end
  end
  
end

