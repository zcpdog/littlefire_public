class User::FavoritesController < UserController
  def index
    @obj_class = Favorite.name.downcase.pluralize
    @objs = Favorite.owned_by(@user).month_of(@current_time)
    @stop = beyond_date?
    respond_to do |format|
      format.html {render "user/show"}
      format.js {render "user/common/index"}
    end
  end
  
  def create
    @favorable = find_polymorphic_object
    @favorite = @favorable.favorites.build
    @favorite.user = current_user
    @favorite.save
    respond_to do |format|
        format.js {render :show}
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
