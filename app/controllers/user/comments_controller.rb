class User::CommentsController < UserController
  def index
    @comments = Comment.page params[:page]
  end
  
  def show_recent
    @deal_id = params[:deal_id]
    @comments = Comment.where(:deal_id => params[:deal_id])
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.deal= Deal.find params[:deal_id]
    @comment.user = current_user if user_signed_in?
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
