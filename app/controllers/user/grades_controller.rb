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
    @gradable = find_polymorphic_object
    @grade = Grade.new(user_id: current_user.id, gradable: @gradable, grade_type: params[:grade_type])
    @grade.save
    respond_to do |format|
        format.js {render :show}
    end
  end
end
