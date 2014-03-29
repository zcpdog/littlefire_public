class RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)
    params[:user].delete(:email)
    successfully_updated = if params[:user][:password].present?
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      flash[:notice] = "信息修改成功"
      redirect_to profile_user_path(current_user)
    else
      flash[:notice] = "信息修改失败，请仔细检查"
      redirect_to profile_user_path(current_user)
    end
  end
  
  protected
  def after_inactive_sign_up_path_for(resource)
    "/notify"
  end
end