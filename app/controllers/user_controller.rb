class UserController< ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user
  before_filter :caculate_date, only: [:index]
  def dashboard
    @favorites = Favorite.owned_by(current_user).limit(5)
    @comments  = Comment.all.limit(5)
  end
  
  def show
    @obj_class = Favorite.name.downcase.pluralize
    @objs = Favorite.owned_by(@user)
    caculate_date
    respond_to do |format|
      format.html
    end
  end
  
  def profile
    render "user/profile/show"
  end
  
  protected
    def find_user
      @user = User.find_by(username: params[:username]) || not_found
    end
    
    def current_date
      time = Time.zone.now
      "#{time.year}-#{time.month}"
    end
    
    def caculate_date
      @current_date = params[:date]||current_date
      year = @current_date.split("-")[0]
      month = @current_date.split("-")[1]
      @current_time = Time.new(year,month)
      @next_time = @current_time - 1.month
      @next_date = "#{@next_time.year}-#{@next_time.month}"
    end
    
    def beyond_date?
      @current_time<@user.created_at
    end
end