class DealsController < ApplicationController
  before_filter :find_model, :only => [:show, :edit, :update, :destroy]
  #before_filter
  # GET /models
  # GET /models.xml
  def index
    if params[:category_id].present?
      @category = Category.find_by(id: params[:category_id])||Category.first
      @deals = @category.deals.page params[:page] 
    else
      @search = Sunspot.search(Deal) do
        fulltext params[:search]
        order_by(:created_at, :desc)
        paginate :page => params[:page], :per_page => 20
      end
      @deals = @search.results
    end
    render "welcome/index"
  end
  
  # GET /models/1
  # GET /models/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deal }
    end
  end

  # GET /models/new
  # GET /models/new.xml
  def new
    @deal = Deal.new
    @deal.links.build
    @deal.pictures.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deal }
    end
  end

  # GET /models/1/edit
  def edit
  end

  # POST /models
  # POST /models.xml
  def create
    @deal = Deal.new(deal_params)
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

  # PUT /models/1
  # PUT /models/1.xml
  def update
    respond_to do |format|
      if @deal.update_attributes(deal_params)
        flash[:notice] = 'Deal was successfully updated.'
        format.html { redirect_to(@deal) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.xml
  def destroy
    @deal = Deal.find(params[:deal])
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to(deals_path) }
      format.xml  { head :ok }
    end
  end

  private
    def find_model
      @deal = Deal.find(params[:id])
    end
    def deal_params
      params.require(:deal).permit(:user, :merchant_id,:category_id,:title,:body,:purchase_link,
        :location,:due_date,:amazing_price, pictures_attributes: [:image,:_destroy],
        links_attributes: [:url,:_destroy])
    end

end

