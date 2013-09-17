class User::GradesController < UserController
  def index
    @grades = Grade.deal_grades.owned_by(current_user).page params[:page]
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
