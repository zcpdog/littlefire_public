class User::DealsController < UserController
  #before_filter :find_user
  #before_filter :find_user_deal, :only => [:show, :edit, :update, :destroy]
  def index
    @deals = Deal.where(user: current_user).page params[:page]
  end
  
  def show
  end
  
end

