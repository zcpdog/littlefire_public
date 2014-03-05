class UserController< ApplicationController
  before_filter :authenticate_user!
  def dashboard
    @favorites = Favorite.owned_by(current_user).limit(5)
    @comments  = Comment.all.limit(5)
  end
  
  def show
    @user = User.find_by(username: params[:username]) || not_found
    @objs  = Comment.owned_by(@user)
  end
  def profile
    render "user/profile/show"
  end
  
end