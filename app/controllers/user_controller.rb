class UserController< ApplicationController
  before_filter :authenticate_user!
  def dashboard
    @favorites = Favorite.stored_by(current_user).limit(5)
    @comments  = Comment.all
  end
end