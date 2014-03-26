class UserController< ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user, :caculate_date, only: [:index,:show]
  def dashboard
    @favorites = Favorite.owned_by(current_user).limit(5)
    @comments  = Comment.all.limit(5)
  end
  
  def show
    @obj_class = Favorite.name.downcase.pluralize
    @objs = Favorite.includes(favorable: :picture).owned_by(@user)
    respond_to do |format|
      format.html
    end
  end
  
  def profile
  end
  
  def change_password
  end
  
  protected
    def find_user
      @user = User.friendly.find params[:id] || not_found
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
    
    def find_polymorphic_object
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.friendly.find(value)
        end
      end
      nil
    end
end