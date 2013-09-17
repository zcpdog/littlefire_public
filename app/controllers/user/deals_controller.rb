class User::DealsController < UserController
  def index
    @deals = Deal.owned_by(current_user).page params[:page]
  end
  
  def show
  end
  
end

