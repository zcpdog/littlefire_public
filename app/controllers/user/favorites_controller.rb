class User::FavoritesController < UserController
  def index
    @favorites = Favorite.page params[:page]
  end
  
  def create
    @favorite = Favorite.new
    @favorite.deal= Deal.find params[:deal_id]
    @favorite.user = current_user if user_signed_in?
    if cookies[:favorited_list].blank?
      cookies[:favorited_list] = params[:deal_id]
    else
      cookies[:favorited_list] = cookies[:favorited_list] << ",#{params[:deal_id]}"
    end
    puts cookies[:favorited_list]
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
