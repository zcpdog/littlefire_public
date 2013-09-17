class User::FavoritesController < UserController
  def index
    @favorites = Favorite.owned_by(current_user).page params[:page]
  end
  
  def create
    @favorite = Favorite.new
    @favorite.favorable= Deal.find params[:deal_id]
    @favorite.user = current_user
    respond_to do |format|
      if @favorite.save
        format.html
        format.js {render :show}
      end
    end
  end
  
  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    respond_to do |format|
      format.html
      format.js {render :delete}
    end
  end
end
