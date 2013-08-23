class User::PicturesController < UserController
  def create
    @picture = Picture.new(picture_params)
    Picture.transaction do 
      current_user.picture.destroy unless current_user.picture.nil?
      @picture.imageable = current_user
      @picture.save
    end
    redirect_to user_profile_path
  end
  
  private
  def picture_params
    params.require(:picture).permit(:image)
  end
end
