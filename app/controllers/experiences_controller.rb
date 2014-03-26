class ExperiencesController < ApplicationController
  before_filter :authenticate_user!, :only =>[:new, :create]
  
  def new
    @experience = Experience.new
    @experience.build_picture
  end
  
  def show
    @experience = Experience.friendly.find(params[:id])
    not_found unless current_admin_user.present? or @experience.active? or (current_user.present? and @experience.owned_by? current_user)
  end
  
  def index
    @experiences = Experience.cached_published(params[:page])
  end
  
  def create
    @experience = Experience.new(discovery_params)
    @experience.user = current_user
    respond_to do |format|
      if @experience.save
        flash[:notice] = '晒单发布成功！'
        format.html { redirect_to experiences_path }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  private
    def discovery_params
      params.require(:experience).permit(:title,:content,picture_attributes: [:image, :image_cache])
    end
end