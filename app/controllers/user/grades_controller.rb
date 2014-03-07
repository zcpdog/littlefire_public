class User::GradesController < UserController
  def index
    @obj_class = Grade.name.downcase.pluralize
    @objs = Grade.owned_by(@user).month_of(@current_time)
    @stop = beyond_date?
    respond_to do |format|
      format.html {render "user/show"}
      format.js {render "user/common/index"}
    end
  end
  
  def create
    @grade =Grade.new(gradable_id: params[:gradable_id],
     gradable_type: params[:gradable_type],user: current_user, agree: params[:agree])
    respond_to do |format|
      if @grade.save
        format.html
        format.js {render :show}
      end
    end
  end
end
