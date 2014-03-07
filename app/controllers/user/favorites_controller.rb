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
