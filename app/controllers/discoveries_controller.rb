class DiscoveriesController < ApplicationController
  before_filter :authenticate_user!, :only =>[:new, :create]

  def index
    @discoveries = Discovery.cached_published(params[:page])
  end
  
  def purchase
    @discovery = Discovery.find(params[:id])
    render layout: "devise"
  end

  def show
    @discovery = Discovery.friendly.find(params[:id])
  end
  
  def new
    @discovery = Discovery.new
    @discovery.build_picture
  end

  def create
    @discovery = Discovery.new(discovery_params)
    @discovery.user = current_user
    respond_to do |format|
      if @discovery.save
        flash[:notice] = '发现发布成功！'
        format.html { redirect_to discoveries_path }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @discovery.update_attributes(discovery_params)
        flash[:notice] = 'Discovery was successfully updated.'
        format.html { redirect_to(@discovery) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  private
    def discovery_params
      params.require(:discovery).permit(:title,:content,:purchase_link,:merchant_id,picture_attributes: [:image, :image_cache])
    end

end

