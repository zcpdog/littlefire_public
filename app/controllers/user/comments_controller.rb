class User::CommentsController < UserController
  def create
    @comment =Comment.new(deal: params[:deal_id], user: current_user)
  end
end
