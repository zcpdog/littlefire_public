class User::CommentsController < UserController
  def index
    @comments = Comment.owned_by(current_user).page params[:page]
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
