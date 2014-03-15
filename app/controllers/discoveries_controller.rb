class DiscoveriesController < ApplicationController
  before_filter :authenticate_user!, :only =>[:new, :create]

  def index
    @discoveries = Discovery.all
  end
  
  def search
    if params[:category_id].present?
      @category = Category.find_by(id: params[:category_id])||Category.first
      @keyword = @category.name
      @deals = @category.deals.page params[:page] 
    else
      @keyword = params[:q]
      @search = Sunspot.search(Deal) do
        fulltext params[:q]
        with(:state, ["published","deprecated"])
        order_by(:created_at, :desc)
        paginate :page => params[:page], :per_page => 20
      end
      @deals = @search.results
    end
  end
  
  def purchase
    @deal = Deal.find(params[:id])
    render layout: "devise"
  end

  def show
    @deal = Deal.find(params[:id])
    not_found unless @deal.active? or (current_user.present? and @deal.owned_by? current_user)
  end
  
  def new
    @discovery = Discovery.new
    @discovery.build_picture
  end

  def create
    @discovery = Discovery.new(deal_params)
    @discovery.user = current_user
    respond_to do |format|
      if @discovery.save
        flash[:notice] = '发现发布成功！'
        format.html { redirect_to root_path }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def unfold
    @deal = Deal.find params[:id]
    respond_to do |format|
      format.js
    end
  end
  
  def update
    respond_to do |format|
      if @deal.update_attributes(deal_params)
        flash[:notice] = 'Deal was successfully updated.'
        format.html { redirect_to(@deal) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  private
    def find_model
      @deal = Deal.find(params[:id])
    end
    
    def deal_params
      params.require(:discovery).permit(:title,:content,:purchase_link,:merchant_id,picture_attributes: [:image, :image_cache])
    end

end

