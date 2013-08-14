class User::FavoritesController < UserController
  def index
    @favorites = Favorite.page params[:page]
  end
  
  def create
    @favorite = Favorite.new
    @favorite.deal= Deal.find params[:deal_id]
    @favorite.user = current_user if user_signed_in?
    respond_to do |format|
      if @favorite.save
        format.html
        format.js {render :show}
      end
    end
  end
  
  def destroy
    @deal = Deal.find(params[:deal])
    @deal.destroy
    respond_to do |wants|
      wants.html { redirect_to(deals_path) }
      wants.xml  { head :ok }
    end
  end
end
