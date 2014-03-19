class User::CommentsController < UserController
  def index
    @obj_class = Comment.name.downcase.pluralize
    @objs = Comment.includes(:commentable).owned_by(@user).month_of(@current_time)
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
    @commentable = find_polymorphic_object
    @comment = @commentable.comments.build(params[:comment].permit(:content))
    @comment.user = current_user
    @comment.save
    render partial: 'comment', locals: {comment: @comment}
  end
end
