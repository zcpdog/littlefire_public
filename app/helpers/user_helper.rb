module UserHelper
  def generate_label label ,user
    if user == current_user
      prelabel = "我的"
    else
      prelabel = "#{user.username}的"
    end
    prelabel+label
  end
end