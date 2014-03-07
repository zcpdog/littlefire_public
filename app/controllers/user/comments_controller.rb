class User::CommentsController < UserController
  def index
    @obj_class = Comment.name.downcase.pluralize
    @objs = Comment.owned_by(@user).month_of(@current_time)
    @stop = beyond_date?
    respond_to do |format|
      format.html {render "user/show"}
      format.js {render "user/common/index"}
    end
  end
  
  def show_recent
    @deal = Deal.find params[:deal_id]
    @comments = Comment.where(:commentable => @deal)
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = Deal.find params[:deal_id]
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html
        format.js {render :show}
      end
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
