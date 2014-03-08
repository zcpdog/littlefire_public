class DealsController < ApplicationController
  before_filter :authenticate_user!, :only =>[:new, :create]

  def index
    @deals = Deal.active.page params[:page]
    respond_to do |wants|
      wants.html # index.html.erb
    end
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
  end

  def show
    @deal = Deal.find(params[:id])
    not_found unless @deal.active? or (current_user.present? and @deal.owned_by? current_user)
  end
  
  def new
    respond_to do |format|
      format.html 
    end
  end

  def create
    @deal = Deal.new(deal_params)
    @deal.user = current_user
    respond_to do |format|
      if @deal.save
        flash[:notice] = 'Deal was successfully created.'
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
      params.require(:deal).permit(:title,:content,:purchase_link)
    end

end

