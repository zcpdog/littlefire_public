class UserController< ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user, :caculate_date, only: [:index,:show]
  
  def show
    @obj_class = Favorite.name.downcase.pluralize
    @objs = Favorite.includes(favorable: :picture).owned_by(@user)
  end
  
  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params)
      sign_in @user, :bypass => true
      flash[:notice] = "update password successfully"
      redirect_to profile_user_path(current_user)
    else
      flash[:notice] = "update password error"
      render "profile"
    end
  end
  
  def update_avatar
    @user = User.find(current_user.id)
    if @user.update(user_avatar_params)
      flash[:notice] = "update avatar successfully"
      redirect_to "/user/profile"
    else
      flash[:notice] = "update avatar error"
      render "profile"
    end
  end
  
  def profile
  end
    
  private
    def user_params
      params.required(:user).permit(:password, :password_confirmation,:current_password)
    end
    
    def user_avatar_params
      params.required(:user).permit({picture_attributes: [:image]},
       :password_confirmation, :current_password)
    end
  
  protected
    def find_user
      @user = User.friendly.find(params[:id]||params[:user_id]) || not_found
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